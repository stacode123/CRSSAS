--      ComputerCraft Railway System Status and Announcment System - by Stacode (MIT license)
--                              This is the client
--              Requires a 2x3 Monitor and a (preferebly ender)wireless modem

peripheral.find("modem", rednet.open)
mon = peripheral.find("monitor")
mon.clear()
mon.setBackgroundColor(colors.black)
mon.setCursorPos(1,1)
LargeAnnouncment = false
Announcment = {}
Data = {}
id,msg = nil,nil
Loaded = false

--Tools
function printTable(table)
    for x,y in pairs(table) do
        print(x,y)
    end
    
end

function slice_table(t, x)
    local new_table = {}
    for i = x + 1, #t do
        new_table[#new_table + 1] = t[i]
    end
    return new_table
end

stringtoboolean={ ["true"]=true, ["false"]=false }

--Draw Saved posters and static Texts--
function DrawPoster(Imagefile,textTable)
   print("drawing")
   mon.clear()
   mon.setBackgroundColor(colors.black)
   paintutils.drawImage(Imagefile,1,1)
   if textTable then
    for x, y in ipairs(textTable) do
        temporarydic = {}
        if string.sub(y,1,1) ~= "#" then
            for c in string.gmatch(y,"|([^|]+)") do
                table.insert(temporarydic,c)
            end
            c1 , c2 = temporarydic[4], temporarydic[5]
            mon.setCursorPos(tonumber(temporarydic[1]),tonumber(temporarydic[2]))
            mon.setTextColor(colors[c1])
            mon.setBackgroundColor(colors[c2])
            mon.write(temporarydic[3])
            end 
    end
        
   end
end

--Updates the data from the server
function Update_Data_From_Server()
    while true do
        local id, msg = rednet.receive("Train Status")
        local TempData = msg
        local newData = {}
        if not TempData[1] then
            LargeAnnouncment = TempData[2]
            Announcment = TempData[3]
            TempData = slice_table(TempData,3)
            for i=1, #TempData, 2 do
                table.insert(newData, {key = TempData[i+1], value = TempData[i]})
            end

            Data = newData
            sleep(0.25)
        else
            posters = TempData[3]
            LargeAnnouncment = TempData[4]
            Announcment = TempData[5]
            TempData = slice_table(TempData,5)
            for i=1, #TempData, 2 do
                table.insert(newData, {key = TempData[i+1], value = TempData[i]})
            end

            Data = newData
            sleep(0.25)
            Loaded = true

        end
    end
end

--Prints Dynamic texts on the Status Screen--
function PrintStatusData()
    mon.setBackgroundColor(colors.green)
    mon.setTextColor(colors.black)
    py = 3
    for x,y in ipairs(Data) do
        mon.setBackgroundColor(colors.lime)
        mon.setTextColor(colors.black)
        mon.setCursorPos(1,py)
        mon.write(y.key)
        mon.setCursorPos(5,py)
        mon.setBackgroundColor(colors.cyan)
        if y.value == "No Problems" then
            mon.setBackgroundColor(colors.green)
        elseif y.value == "Reduced Service" then
            mon.setBackgroundColor(colors.yellow)  
        elseif y.value == "Closed" then
            mon.setBackgroundColor(colors.red)      
        end
        l =string.len(y.value)
        if l > 13 then
            mon.write(y.value:sub(1,13))
            mon.setCursorPos(5,py+1)
            mon.write(y.value:sub(14))
        else 
            mon.write(y.value)
        end
        py=py+2


    end
    if not LargeAnnouncment then
        mon.setBackgroundColor(colors.orange)
        for x,y in ipairs(Announcment) do
            mon.setCursorPos(1,18+x-1)
            mon.write(y)
        end
    end
end


--Loop through Posters
function main() 
mon.write("Waiting For Data...")
while not Loaded do
    sleep(1)
end
firstBoot = true
while true do
    for x = 1,#posters,2 do
        sleep(1)    
        --Skip Status Board for the first Boot--
        if firstBoot then
            firstBoot =false
            goto continue
        end
        DrawPoster(posters[x],posters[x+1])
        --Print Status Data And announcments--
        if x == 1 then
            PrintStatusData()
            sleep(5)
            if LargeAnnouncment then
                paintutils.drawFilledBox(1,1,18,19,colors.orange)
                mon.setBackgroundColor(colors.orange)
                mon.setCursorPos(1,1)
                for x,y in ipairs(Announcment) do
                    mon.write(y)
                    mon.setCursorPos(1,x)
                end
                sleep(5)
            end
            
        end
        sleep(5)
        ::continue::
    end
    

end
end

--Parrarel run the Server Data Fetcher and the main poster loop
parallel.waitForAll(main,Update_Data_From_Server)






