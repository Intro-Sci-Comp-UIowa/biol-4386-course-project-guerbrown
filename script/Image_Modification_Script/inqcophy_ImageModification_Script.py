import os

# Specify the directory containing the SVG images
input_dir = '/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output'

# Loop through each SVG file in the input directory
for filename in os.listdir(input_dir):
    if filename.endswith('.svg'):
        # Define the input and output filenames
        input_file = os.path.join(input_dir, filename)
        output_file = os.path.join(input_dir, 'no_bg_' + filename)
        
        # Print the output file path for debugging
        print(f'Saving output to {output_file}')
        
        # Call Inkscape to remove the background
        os.system(f'inkscape --export-background-opacity=0 --export-png={output_file} {input_file}')

