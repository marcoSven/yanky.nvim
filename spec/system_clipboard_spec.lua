local yanky = require("yanky")
local system_clipboard = require("yanky.system_clipboard")

describe("Sync clipbard", function()
  before_each(function()
    yanky.setup({
      ring = {
        storage = "memory",
      },
      system_clipboard = {
        sync_with_ring = true,
      },
    })
  end)

  it("should add system clipboard to history on focus", function()
    vim.fn.setreg("*", "default_value", "V")
    system_clipboard.on_focus_lost()

    vim.fn.setreg("*", "new_value", "v")
    system_clipboard.on_focus_gained()

    assert.are.same(yanky.history.first(), {
      regcontents = "new_value",
      regtype = "v",
    })
  end)
end)
