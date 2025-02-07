require('git'):setup()
if os.getenv("NVIM") then
    require("hide-preview"):entry()
end
