{ ... }:
{
  programs.nixvim.plugins = {
    bufferline.settings.options = {
      diagnostics = "nvim_lsp";
      diagnosticsIndicator = ''
        function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
        	local sym = e == "error" and " "
        		or (e == "warning" and " " or "")
        		s = s .. n .. sym
        		end
        		return s
        		end
        		'';
      offsets = [ { filetype = "NvimTree"; } ];
      mode = "tabs";
      hover = {
        enabled = true;
        reveal = [ "close" ];
      };
    };

    web-devicons.enable = true;
  };
}
