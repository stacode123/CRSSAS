--      ComputerCraft Railway System Status and Announcment System - by Stacode (MIT license)
--                         This is the server(ONLY 1 PER WORLD)
--                              Requires a wireless modem
--                           The server HAS to be chunk loaded


peripheral.find("modem", rednet.open)
rednet.host("Train Status","Status Server")

--Setup Vars--
local basalt = require("basalt")
local main = basalt.createFrame():setOffset(0,0)
message = {}
DropdownCount = 0
Dropdowns = {}
DropdownsSel = {}
labels = {}
trainNameText = "R1"
local popoutButtonPressed = false
sendingFiles = true
Change = true

--Tools-
function printTable(table)
    for x,y in pairs(table) do
        basalt.debug(x,y)
    end
    
end

--Some GUI Setup
local popup = main:addFrame():setSize(30, 10):setPosition(10, 5):setBackground(colors.gray):setVisible(false):setBorder(colors.yellow) 

local confirmButton = main:addButton():setText("Send"):setPosition(19,16):setBackground(colors.yellow):setSize(8,3)


-- Encodes the Data to be sent to the clients--
function createMessage(chk,txt)
    tmessage = {}
    table.insert(tmessage,sendingFiles)
    if not sendingFiles then
        table.insert(tmessage,chk:getValue())
        table.insert(tmessage,txt.getLines())
        for x,y in ipairs(Dropdowns) do
            Status = Dropdowns[x]:getValue().text
            Line = labels[x]:getText()
            table.insert(tmessage,Status)
            table.insert(tmessage,Line)
        end
    else
        --Import posters--
        PosterNumber = 1
        posters = {}
        --Probe to check how many posters are available--
        while fs.exists(string.gsub("/Posters/Poster{}.nfp","{}",PosterNumber)) do
            PosterNumber = PosterNumber + 1
        end    
        table.insert(tmessage,(PosterNumber-1)*2)
        PosterNumber = 1
        --Load theses Posters--
        while fs.exists(string.gsub("/Posters/Poster{}.nfp","{}",PosterNumber)) do
            t = paintutils.loadImage(string.gsub("/Posters/Poster{}.nfp","{}",PosterNumber))
            x = fs.open("/Posters/Poster" .. tostring(PosterNumber) .. "text","r")
            table.insert(posters,t)
            local lines = {} for line in x.readAll():gmatch("[^\r\n]+") do lines[#lines+1] = line end
            table.insert(posters,lines)
            PosterNumber = PosterNumber+1
        end
        table.insert(tmessage,posters)
        --Yeah not the cleanest--
        table.insert(tmessage,chk:getValue())
        table.insert(tmessage,txt.getLines())
        for x,y in ipairs(Dropdowns) do
            Status = Dropdowns[x]:getValue().text
            Line = labels[x]:getText()
            table.insert(tmessage,Status)
            table.insert(tmessage,Line)
        end
        
    end    
    message = tmessage
    basalt.debug(printTable(tmessage))
end  

--Shows the popup asking for the lien name--
function showPopup()
    popup:setVisible(true)
end

--Adds a new line to the GUI--
function faddDropdown()
    popup:hide()
    Change = true
    table.insert(Dropdowns,main:addDropdown():setPosition(5,3+DropdownCount*2):setSize(20,1):setDropdownSize(20,3))
    DropdownCount = DropdownCount + 1
    Dropdowns[DropdownCount]:addItem("No Problems", colors.green, colors.black)
    Dropdowns[DropdownCount]:addItem("Reduced Service", colors.yellow, colors.black)
    Dropdowns[DropdownCount]:addItem("Closed", colors.red, colors.black)
    Dropdowns[DropdownCount]:onChange(function(self,event,value)
        Change = true
        self:setBackground(value.bgCol)
    end)
    
    table.insert(labels,main:addLabel():setPosition(1,3+(DropdownCount-1)*2):setSize(3,1):setText(trainNameText):setBackground(colors.green))
    if DropdownCount ==7 then
        newLineButton:hide()
    else
        newLineButton:setPosition(0,2,true)
    end
    
end


--MORE GUI Setup--

LabelPopup = popup:addLabel():setPosition(8, 2):setText("Enter Line Name"):setForeground(colors.white):setBackground(colors.gray):setFontSize(1)
trainName = popup:addInput():setPosition(12, 5):setSize(7, 1):setBackground(colors.white):setForeground(colors.gray):setInputLimit(3)
trainName:onChange(function(self,event,value)
    trainNameText = value
end)
closePopup = popup:addButton():setPosition(30,1):setBackground(colors.red):setForeground(colors.black):setText("x"):setSize(1,1):onClick(function (self,event,value)
    popup:hide()
    
end)
confirmPopButton = popup:addButton():setPosition(12, 8):setSize(8, 1):setText("Confirm"):setBackground(colors.green):setForeground(colors.white)
confirmPopButton:onClick(faddDropdown)

local customMessageLabel = main:addLabel():setPosition(33,1)
customMessageLabel:setText("Custom Message")

local customMessageLabel = main:addLabel():setPosition(9,1)
customMessageLabel:setText("Lines")

local customMessage = main:addTextfield():setSize(18,2):setPosition(29,4)

local LargeCheckbox = main:addCheckbox():setPosition(27,3):show():setSize(1,1):setBackground(colors.gray):setBorder(colors.black):onChange(function(self,event,value)
    if value then
        customMessage:setSize(18,14)
    else
        customMessage:setSize(18,2)
    end
end)
local CheckboxLabel = main:addLabel():setPosition(29,3)
CheckboxLabel:setText("Show on Seperate Screen")

newLineButton = main:addButton():setText("+"):setSize(3,1):setBackground(colors.orange):setPosition(10,3)


confirmButton:onClick(function(self,event,button,x,y)
    if(event=="mouse_click")and(button==1)then
      createMessage(LargeCheckbox,customMessage)
      Change = false
      confirmButton:setBackground(colors.green)
    end
  end)
newLineButton:onClick(function (self,event,button,x,y)
    if(event=="mouse_click")and(button==1)then
        showPopup()
      end
    
end)



--And finnaly the main program loops--

local function sendLoop()
    while true do
        if message ~= {} then
            rednet.broadcast(message,"Train Status")
            sleep(0.1)
        end    
    end
end


local function inputLoop()
    while true do
        if Change then
            confirmButton:setBackground(colors.yellow)
        else
            confirmButton:setBackground(colors.green)
        end
        basalt.autoUpdate() 
        sleep(0.05)
    end
end

parallel.waitForAll(sendLoop, inputLoop)

