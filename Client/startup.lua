mon = peripheral.find("monitor")

for _, side in ipairs(peripheral.getNames()) do
    if peripheral.getType(side) == "monitor" then
        shell.run(string.gsub("monitor {} client","{}",side))
    end
end

