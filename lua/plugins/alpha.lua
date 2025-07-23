return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
         ss½                 óó
       ööösu‰                3ÏÏÏ
     C@@@@n¢¢s               ±±±±±L
   LóóóóóóCssss              VÍÍÍÍÍÍV
 yfŸÏÌÌÌÌÌónnnnn@            000000000ç
ÎÎÎÎ§2ÏÏÏÏÌ@@@@@@@           ©YYYYYY£YYY
yOOOOTŸ±±±ÏCCCCCCCC          w©©©©©©©©©ç
6µµµµµµàLLLÌÌÌÌÌÌÌÌÌ         ùçççççççççù
TTTTeeTTÇVÍ33±3333333        2222222222™
UUUUUUUUUšw±±±±±±±±±±±L      aüüüüüüüüüü
SSSSSSSSSSkVÍÍÍÍÍÍÍÍÍÍÍL     ô&&&&&&&ú&ú
Ÿ®®®®®®®®®S  0000000000£0    õôôôô5ôôôô5
ŸkkkkkkkkkŸ   YYYYYYYYYYYY   õõõõõõõ4õõõ
§ÝkÝÝÝÝÝÝÝÝ    w©©©©©©©©©©©w ¾fffffffff¾
ûûhûûàûhhhh     wwwwwwwwwwwwçxÎÎÎÎÎÎÎÎÎÎ
ààààààààààà      ™22222222222™yyyyyyyyyy
ÇšššššššššP        aaüüaüüüaaaaµOµµµµµµµ
PPPPPPPPPPZ         aaaa&aaaaúúú6e666666
áZZZZZZZZZZ          &úúúúúúúô555OUUUUUU
DFFFFFFFFFD           ôôôôôôôõõõõõfžžžžž
 F¥¥¥F¥¥¥¥¥            xõõõõõfffffff®®®
   bbbbbbb¥              ¾¾¾f¾ÎÎÎÎÎÎÎ
     ÿååååÿ               ÎÎÎÎxxxxy
       ÞÞÞÞ                xxyOOO
         ÞÓ                 xOµ
    ]]
    dashboard.section.buttons.val = {
    }
    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.opts.layout[1].val = 4
    dashboard.section.header.opts.hl = "AlphaHeader"
    return dashboard
  end,
  config = function(_, dashboard)
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)
  end,
}
