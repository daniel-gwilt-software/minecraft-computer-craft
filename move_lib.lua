function turtleMoveReadme()
    print("Welcome to the turtle mover library by Daniel Gwilt")
end

function moveForward(distance)
    for i=1, distance do
        turtle.forward()
    end
end

function moveBackward(distance)
    for i=1, distance do
        turtle.back()
    end
end

function moveUp(distance)
    for i=1, distance do
        turtle.up()
    end
end

function moveDown(distance)
    for i=1, distance do
        turtle.down()
    end
end

function turnAround()
    turtle.turnRight()
    turtle.turnRight()
end