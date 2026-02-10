{
  ...
}:

{
  programs.nixvim = {
    enable = false;
    viAlias = true;
    vimAlias = true;

    # Basic options
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      swapfile = false;
      termguicolors = true;
    };

    # Plugins
    plugins = {
      lualine = {
        enable = true;
      };
      web-devicons = {
        enable = true;
      };

      nvim-tree = {
        enable = true;
        openOnSetup = true;

        settings = {
          disableNetrw = true;
          hijackNetrw = true;
          updateFocusedFile.enable = true;
          view = {
            width = 30;
            side = "left";
          };
          renderer = {
            highlightGit = true;
            icons.show.file = true;
            icons.show.folder = true;
          };
        };
      };

      telescope = {
        enable = true;
      };

      treesitter = {
        enable = true;
      };

      presence = {
        enable = true;
        settings = {
          enableLineNumber = true;
          autoUpdate = true;
        };
      };

      cmp.enable = true;
      comment.enable = true;

      vim-surround.enable = true;
      fugitive.enable = true;

      # LSP plugin and servers
      lsp = {
        enable = true;
        servers = {
          lua_ls = { };
          pyright = { };
          ts_ls = { };
          nil_ls = {
            enable = true;
            settings = {
              formatting.command = [ "nixpkgs-fmt" ];
            };
          };
        };
      };
    };

    globals = {
      mapleader = " "; # Use space as leader
      maplocalleader = " "; # Optional: set local leader too
    };

    # Key mappings
    keymaps = [
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find files";
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        key = "<leader>w";
        action = "<cmd>NvimTreeToggle<cr>";
        options.desc = "Toggle file explorer";
      }
      {
        key = "<leader>n";
        action = "<cmd>NvimTreeFindFile<cr>";
        options.desc = "Find current file in explorer";
      }
    ];
  };
}
