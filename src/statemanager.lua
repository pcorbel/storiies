local StateManager = {}
StateManager.__index = StateManager

local StateData = require("src.statedata")

local currentState = nil
local stateStack = {}
local stateData = StateData:new()

function StateManager:new()
    return setmetatable({}, StateManager)
end

function StateManager:getStateData()
    return stateData
end

function StateManager:switch(newState)
    if currentState and currentState.leave then
        currentState:leave()
    end

    currentState = newState
    stateStack = { newState }

    if currentState and currentState.enter then
        currentState:enter()
    end
end

function StateManager:push(newState)
    if currentState and currentState.leave then
        currentState:leave()
    end

    table.insert(stateStack, newState)
    currentState = newState

    if currentState and currentState.enter then
        currentState:enter()
    end
end

function StateManager:pop()
    if #stateStack > 1 then
        if currentState and currentState.leave then
            currentState:leave()
        end

        table.remove(stateStack)
        currentState = stateStack[#stateStack]

        if currentState and currentState.enter then
            currentState:enter()
        end
    end
end

function StateManager:update(dt)
    if currentState and currentState.update then
        currentState:update(dt)
    end
end

function StateManager:draw()
    if currentState and currentState.draw then
        currentState:draw()
    end
end

function StateManager:keypressed(key)
    if currentState and currentState.keypressed then
        currentState:keypressed(key)
    end
end

return StateManager
