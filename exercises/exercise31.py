def letter(first_name, last_name, signature_name):
    opening = opening_given_first_name(first_name)
    body = body_given_first_name_and_last_name(first_name, last_name)
    closing = closing_given_signature_name(signature_name)
    full_letter = opening + '\n\n' + body + '\n\n' + closing
    return full_letter

def opening_given_first_name(first_name):
    return f'Dear {first_name},'

def body_given_first_name_and_last_name(first_name, last_name):
    body_1 = f'We have discovered that all people with the\nlast name {last_name} have won our lottery. So, '
    body_2 = f'\n{last_name}, hurry and pick up your prize.'
    body = body_1 + body_2
    return body

def closing_given_signature_name(signature_name):
    closing = f'Sincerely,\n\n{signature_name}\n'
    return closing

def main(filename_for_first_name, filename_for_last_name, filename_for_signature_name, filename_for_output_letter):
    breakpoint()
    with open(filename_for_first_name) as file_handle_filename_for_first_name:
        first_name = file_handle_filename_for_first_name.read().rstrip()
    with open(filename_for_last_name) as file_handle_filename_for_last_name:
        last_name = file_handle_filename_for_last_name.read().rstrip()
    with open(filename_for_signature_name) as file_handle_filename_for_signature_name:
        signature_name = file_handle_filename_for_signature_name.read().rstrip()
    letter_given_names_from_files = letter(first_name, last_name, signature_name)
    with open(filename_for_output_letter, 'w') as file_handle_for_output_letter_file:
        file_handle_for_output_letter_file.write(letter_given_names_from_files)
    return filename_for_output_letter

# import os
# os.chdir('../DrRacket/examples')
# main('first-name.txt', 'last-name.txt', 'signer-name.txt', 'output-letter-py.txt')
