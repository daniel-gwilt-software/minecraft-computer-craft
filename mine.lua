x = 0 -- Forward / Backward
y = 0 -- Up / Down
z = 0 -- Right / Left
goingBack = false
goingDown = false

function main()
    mine(6, 3, 7)
    print ("x = " .. x .. ", y = " .. y .. ", z = " .. z)
end

function mine(dx, dy, dz)
    for i=1, dy do
        mineStory(dx, dz)
        goToStoryStart()
        turnAround()
        goingBack = false
        -- don't dig up on last story
        if i ~= dy then
            digUp(3)
            y = y + 3
        end
    end
    goHome()
    emptyInventory(2)
    turnAround()
end

function mineStory(dx, dz)
    for i=1, dz do
        digForward(dx)
        if dz ~= i then -- Don't uTurn at end of story
            if goingBack then
                uTurnLeft()
            else
                uTurnRight()
            end
        end
    end
    -- Get the last bits at the end of the story
    turtle.digUp()
    turtle.digDown()
end

function dropTorch(inventoryLocation)
    inventoryLocation = inventoryLocation or 1
    turtle.select(inventoryLocation)
    turtle.placeDown()
end

function isTorchSpot(gap)
    gap = gap or 6
    return x % gap == 0 and z % gap == 0 and y == 0
end

function turnAround()
    turtle.turnRight()
    turtle.turnRight()
end

function emptyInventory(start)
    start = start or 1 -- set default parameter
    for i=start, 16 do
        turtle.select(i)
        turtle.drop()
    end
end

function goHome()
    if not goingBack then
        turnAround()
        goingBack = true
    end
    moveForward(x)
    turtle.turnRight()
    moveForward(z)
    turtle.turnLeft()
    moveDown(y)
    x = 0
    y = 0
    z = 0
end

function goToStoryStart()
    if not goingBack then
        turnAround()
        goingBack = true
    end
    moveForward(x)
    turtle.turnRight()
    moveForward(z)
    turtle.turnLeft()
    x = 0
    z = 0
end

function uTurnLeft()
    turtle.turnLeft()
    smartMineForward()
    turtle.turnLeft()
    z = z + 1
    goingBack = not goingBack
end

function uTurnRight()
    turtle.turnRight()
    smartMineForward()
    turtle.turnRight()
    z = z + 1
    goingBack = not goingBack
end

function moveBackward(distance)
    for i=1, distance do
        turtle.back()
    end
end

function moveForward(distance)
    for i=1, distance do
        turtle.forward()
    end
end

function moveDown(distance)
    for i=1, distance do
        turtle.down()
    end
end

function digUp(distance)
    print ("Digging up " .. distance)
    for i=1, distance do
        smartMineUp()
    end
end

-- Dig below, in front and above in strait horizontal line.
function digForward(distance)
    print ("Digging forward " .. distance)
    for i=1, distance do
        smartDig()
        smartMineForward()
        if goingBack then
            x = x -1
        else
            x = x + 1
        end
    end
end

-- Dig front, up and down
function smartDig()
    turtle.dig()
    turtle.digUp()
    turtle.digDown()
end

-- Only move forward if you don't detect a block
function smartMineForward()
    while(turtle.detect()) do
        smartDig()
        sleep(0.5)
    end
    if isTorchSpot() then dropTorch() end
    turtle.forward()
end

-- Only move up if you don't detect a block
function smartMineUp()
    while(turtle.detectUp()) do
        turtle.digUp()
        sleep(0.5)
    end
    turtle.up()
end

main()