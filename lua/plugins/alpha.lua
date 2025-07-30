return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
         bW1                 tI
       HllcyB                JIHN
     tZWxsIGl0               ISBCT1
   lTTUVMTCEhIS              EgSSBzbW
 VsbCBhIGJveSEgVy            1XaGF0IGlz
IGEgQk9ZIGRvaW5nIG           hlcmU/IT8hI
G9teWdvc2ggd2hhdCBh          bSBnb25uYSB
kbz8hPyEgVEhFUkUnUyB         BIEJPWSBIRV
JFISBJJ00gRlJFQUtJTkc        gT1VUIFNPIE
1VQ0ghISEhIGNhbG0gZG93b      iBjYWxtIGRv
d24gYW5kIHRha2UgYSBuaWNl     LCBkZWVwIGJ
yZWF0aGUuLi  4uIHNuaWZmIH    NuaWZmIGl0I
HNtZWxscyBz   byBnb29kISBJ   IGxvdmUgYm9
5c21lbGwgc2    8gbXVjaCEhISE gSXQgbWFrZX
MgbWUgZmVlb     CBzbyBhbWF6aW5nLiBJJ20gZ
2V0dGluZyB0      aW5nbGVzIGFsbCBvdmVyIGZ
yb20gdGhlIG        RlbGljaW91cyBib3lzY2V
udCEgSXQncy         Bkcml2aW5nIG1lIGJveU
NSQVpZISEhI          SEhIGlmIHUgYXJlIGEg
Ym95IGFuZCB           1IGFyZSByZWFkaW5nI
 HRoaXMsIEk            ganVzdCB3YW50ZWQ
   gdG8gc2F              5IGhpaWlpaSB
     jdXRlI               GJveSEhIS
       EgbG                92ZSB5
         b3                 Uh=
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
