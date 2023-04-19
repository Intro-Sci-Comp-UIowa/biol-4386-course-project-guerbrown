from PIL import Image, ImageDraw, ImageFont

def scale_default_font(size):
    font_path = '/usr/share/fonts/truetype/freefont/FreeMono.ttf'
    try:
        font = ImageFont.truetype(font_path, size)
    except OSError:
        font = ImageFont.load_default()
    return font

def add_label(image, label):
    draw = ImageDraw.Draw(image)
    try:
        font = ImageFont.truetype('arial.ttf', 70)  # You may need to change the font path if it's different on your system
    except OSError:
        font = scale_default_font(60)
    draw.text((10, 10), label, font=font, fill=(0, 0, 0, 255))

path = '/home/guerbrown/github_local/biol-4386-course-project-guerbrown/final_images/'

file1 = path + 'inqcophy_PACo_Tanglegram_guerbrown_no_bg_.png'
file2 = path + 'inqcophy_PACo_ResBarplot_guerbrown_no_bg_.png'
file3 = path + 'inqcophy_traitmodeling_hairs_guerbrown_no_bg_.png'
file4 = path + 'inqcophy_traitmodeling_oak_section_guerbrown_no_bg_.png'
file5 = path + 'inqcophy_traitmodeling_spines_guerbrown_no_bg_.png'
output_file = path + 'combined_image.png'

# Open the PNG files
img1 = Image.open(file1)
img2 = Image.open(file2)
img3 = Image.open(file3)
img4 = Image.open(file4)
img5 = Image.open(file5)

# Calculate the scaling factor
scaling_factor = (img1.height + img2.height) / (img3.height + img4.height + img5.height)

# Resize the right images
img3_resized = img3.resize((int(img3.width * scaling_factor), int(img3.height * scaling_factor)), Image.LANCZOS)
img4_resized = img4.resize((int(img4.width * scaling_factor), int(img4.height * scaling_factor)), Image.LANCZOS)
img5_resized = img5.resize((int(img5.width * scaling_factor), int(img5.height * scaling_factor)), Image.LANCZOS)

# Add labels to the images
add_label(img1, "A)")
add_label(img2, "B)")
add_label(img3_resized, "C)")
add_label(img4_resized, "D)")
add_label(img5_resized, "E)")

# Create a new image with the combined size
combined_image = Image.new('RGBA', (img1.width + img3_resized.width, max(img1.height + img2.height, img3_resized.height + img4_resized.height + img5_resized.height)))

# Paste the images at the correct positions
combined_image.paste(img1, (0, 0))
combined_image.paste(img2, (0, img1.height))
combined_image.paste(img3_resized, (img1.width, 0))
combined_image.paste(img4_resized, (img1.width, img3_resized.height))
combined_image.paste(img5_resized, (img1.width, img3_resized.height + img4_resized.height))

# Save the combined image
combined_image.save(output_file)

