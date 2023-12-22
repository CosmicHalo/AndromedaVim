Andromeda.mappings.mason = function(_, opts)
  local maps = opts.mappings
  maps.n["<Leader>pm"] = Andromeda.kit.keymap
    .map_callback(function() require("mason.ui").open() end)
    :with_desc("Mason Installer")
  maps.n["<Leader>pM"] = Andromeda.kit.keymap
    .map_callback(function() require("astrocore.mason").update_all() end)
    :with_desc("Mason Update")

  opts.commands.AstroMasonUpdate = {
    function(options) require("astrocore.mason").update(options.fargs) end,
    nargs = "*",
    desc = "Update Mason Package",
    complete = function(arg_lead)
      local _ = require("mason-core.functional")
      return _.sort_by(
        _.identity,
        _.filter(_.starts_with(arg_lead), require("mason-registry").get_installed_package_names())
      )
    end,
  }

  opts.commands.AstroMasonUpdateAll = {
    desc = "Update Mason Packages",
    function() require("astrocore.mason").update_all() end,
  }
end
