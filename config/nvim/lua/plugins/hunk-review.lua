return {
  "shaunchander/hunk-review.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = { "HunkReview", "HunkReviewRefresh", "HunkReviewExport", "HunkReviewReset" },
  opts = {
    layout = {
      explorer_width = 0.2,
    },
  },
}
