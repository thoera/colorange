# display and save one palette
png("palettes/palette_principale.png", width = 1920, height = 1080, res = 150)
display_orange_palette("principale")
dev.off()

# or all the palettes
png("palettes/palettes_all.png", width = 1920, height = 1080, res = 150)
display_orange_all()
dev.off()