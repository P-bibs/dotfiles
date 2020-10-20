#!/usr/bin/env python3
import argparse, re, sys

tex_header = """\\documentclass{article}
\\setlength{\\parskip}{\\baselineskip}%
\\setlength{\\parindent}{0pt}%
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{setspace}
\\usepackage{lipsum}
\\usepackage{amsmath}
\\usepackage{amssymb}
\\usepackage[shortlabels]{enumitem}

\\newcommand{\\ZZ}{\\mathbb{Z}}
\\newcommand{\\CC}{\\mathbb{C}}
\\newcommand{\\RR}{\\mathbb{R}}
\\newcommand{\\hr}{\\underline{\\hspace*{\\textwidth}}}
\\newcommand{\\bv}{\\boldsymbol{v}}
\\newcommand{\\bw}{\\boldsymbol{w}}
\\newcommand{\\bz}{\\boldsymbol{0}}
\\newcommand{\\hf}{\\text{Hom}_F(V,W)}

\\begin{document}
Paul Biberstein\\\\
MATH 1530\\\\
__/__/20

\\Huge\\textbf{Problem Set __} \\\\
\\huge\\textbf{_____________}
\\normalsize
"""

given_goal = """\\textbf{Given:}  \\\\
\\textbf{Goal:}
"""


def parse_problem_numbers(problem):
    pattern = re.compile("^\d*\.?\d*")
    matches = pattern.findall(problem)
    if len(matches) != 1:
        print("ERROR: couldn't parse problem: " + str(problem))
        sys.exit(0)
    problem_number = matches[0]
    return problem_number


def parse_problem_letters(problem_string, problem_number):
    problem_letters = problem_string[len(problem_number) :]

    if "-" in problem_letters:
        first_letter = problem_letters[0]
        last_letter = problem_letters[2]
        return [
            chr(char_code)
            for char_code in range(ord(first_letter), ord(last_letter) + 1)
        ]
    else:
        return list(problem_letters)


def generate_tex(problem_dict):
    tex_body = tex_header

    for problem_number in problem_dict:
        tex_body += "\section*{Problem %s}\n" % problem_number
        if len(problem_dict[problem_number]) == 0:
            tex_body += given_goal
            tex_body += "\n"
        else:
            for problem_letter in problem_dict[problem_number]:
                tex_body += "\subsection*{Part (%s)}\n" % problem_letter
                tex_body += given_goal
                tex_body += "\n"
        tex_body += "\hr\n"

    tex_body += "\end{document}\n"
    return tex_body


def write_tex(filename, tex_body):
    with open(filename, "w") as fd:
        fd.write(tex_body)


def main():
    parser = argparse.ArgumentParser(description="Create Tex file")
    parser.add_argument(
        "filename",
        metavar="filename",
        type=str,
        nargs=1,
        help="problems in the problem set",
    )
    parser.add_argument(
        "problems",
        metavar="problems",
        type=str,
        nargs="+",
        help="problems in the problem set",
    )

    args = parser.parse_args()
    problem_numbers = [parse_problem_numbers(problem) for problem in args.problems]
    problem_dict = {
        problem_number: parse_problem_letters(problem_string, problem_number)
        for problem_string, problem_number in zip(args.problems, problem_numbers)
    }

    tex_body = generate_tex(problem_dict)
    write_tex(args.filename[0], tex_body)
    print("File successfully created")


main()