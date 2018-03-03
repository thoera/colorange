# display and save one palette
png("palettes/palette_main.png", width = 1920, height = 1080, res = 150)
display_orange_palette("main")
dev.off()

# or all the palettes
png("palettes/palettes_all.png", width = 1920, height = 1080, res = 150)
display_orange_all()
dev.off()
