require 'rubygems'
require 'RMagick'
require 'RMagick'

NUM_COLORS = 8
HIST_HEIGHT = 500

img = Magick::Image.read('mel_rocket.jpeg').first
img = img.quantize(NUM_COLORS)

hist = img.color_histogram

# sort pixels by increasing count
pixels = hist.keys.sort_by {|pixel| pixel.to_hsla.first }.compact

scale = HIST_HEIGHT / (hist.values.max*1.025)   # put 2.5% air at the top

gc = Magick::Draw.new
gc.stroke_width(600)
gc.affine(1, 0, 0, -scale, 0, HIST_HEIGHT)

# handle images with fewer than NUM_COLORS colors
start = 40

pixels.each { |pixel|
gc.stroke(pixel.to_color)
gc.line(start, 0, start, hist[pixel])
start = (start+65).succ
}

hatch = Magick::HatchFill.new("white", "gray95")
canvas = Magick::Image.new(NUM_COLORS*60+60, HIST_HEIGHT, hatch)
gc.draw(canvas)

canvas.border!(1, 1, "white")
canvas.border!(1, 1, "black")
canvas.border!(3, 3, "white")
canvas.write("color_histogram.gif")