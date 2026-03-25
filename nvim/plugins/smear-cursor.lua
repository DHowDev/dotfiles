return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      -- Smear color pulled from Normal highlight automatically
      -- Adjust speed: lower = snappier trail, higher = longer tail
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      trailing_exponent = 0.1,
      hide_target_hack = false,
    },
  },
}
