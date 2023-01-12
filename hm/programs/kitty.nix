{ ... }:

{
  programs.kitty = {
    enable = false;
    theme = "Space Gray Eighties";
    settings = {
      font_family = "Jetbrains Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 14;
      disable_ligatures = "never";
      cursor_shape = "beam";
      cursor_beam_thickness = 1;
      initial_window_width = 1080;
      initial_window_height = 720;
    };
  };
}
