import os

# Specify the directory containing the SVG images
input_dir = '/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output'
output_dir = '~/github_local/biol-4386-course-project-guerbrown/final_images'

# Loop through each SVG file in the input directory
for filename in os.listdir(input_dir):
    if filename.endswith('.svg'):

        # Define the input and output filenames
        input_file = os.path.join(input_dir, filename)
        output_file = os.path.join(output_dir, filename + 'no_bg_')
        
        # Call Inkscape to remove the background
        os.system(f'inkscape --export-background-opacity=0 --export-svg={output_file} {input_file}')
