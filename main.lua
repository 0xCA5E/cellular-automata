WHITE = {255/255, 255/255, 255/255}
TAN = {228/255, 166/255, 114/255}
GREY = {175/255, 191/255, 210/255}
BLUE = {4/255, 132/255, 209/255}

WIDTH, HEIGHT = love.graphics.getPixelWidth(), love.graphics.getPixelHeight()
SCALE = 1

CellProps = {
    NONE = 1,
    MOVE_DOWN = 2,
    MOVE_DOWN_SIDE = 3,
    MOVE_SIDE = 4
}

CellType = {
    EMPTY = 1, 
    SAND = 2, 
    ROCK = 3, 
    WATER = 4
}

Cell = {
    new = function(type, props, color) 
        return {
            type = type or CellType.EMPTY,
            props = props or CellProps.NONE,
            color = color or WHITE
            
        } 
    end
}

function love.load()
    love.graphics.setColor(EMPTY)
    cells = {}
end


function love.draw()
    loadPixels()

    if love.mouse.isDown(1) then
        for x=1,20 do
            for y=1,20 do
                setCell(love.mouse.getX() + x, love.mouse.getY() + y, SAND)
            end
        end
        
    end

    for x=1,WIDTH do
        for y=1,HEIGHT do
            local cell = getCell(x, y)
            if cell == SAND then
                local down  = isEmpty(x, y + 1)
                local left  = isEmpty(x - 1, y + 1)
                local right = isEmpty(x + 1, y + 1)

                if down then setCell(x, y + 1, SAND)
                elseif left then setCell(x, y + 1, SAND)
                elseif right then setCell(x, y + 1, SAND) 
                end

                if down or left or right then
                    setCell(x, y, EMPTY)
                end

            end
        end
    end

    updatePixels()
end

function getCell(index) 
    return cells[index]
end

function getCell(x, y) 
    return cells[getIndex(x, y)]
end

function getIndex(x, y)
    return x + y * WIDTH
end

function inBounds(x, y)
    return x < WIDTH && y < HEIGHT
end

function isEmpty(x, y)
    return inBounds(x, y) and getCell(x, y).type == CellType.EMPTY
end

function setCell(x, y, cell)
    cells[getIndex(x, y)] = cell
end



