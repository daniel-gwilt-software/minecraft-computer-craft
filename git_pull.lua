local gitUrl = "https://raw.githubusercontent.com/daniel-gwilt-software/minecraft-computer-craft/master/"
local file = "move_lib.lua"
local httpHandler = http.get(gitUrl .. file)
local fileHandler = fs.open(file, "w")

fileHandler.write(httpHandler.readAll())

httpHandler.close()
fileHandler.close()