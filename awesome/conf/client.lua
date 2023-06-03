--- Change focus when the cursor enters any other window. 
client.connect_signal("mouse::enter", function(c)
    c:activate{context = "mouse_enter", raise = false}
end)
--[[  ]]
