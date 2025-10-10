def marks(marks: int) -> str:
    if 100 >= marks > 90:
        return "A"
    elif 89 >= marks > 80:
        return "B"
    elif 79 >= marks > 70:
        return "C"
    elif 69 >= marks > 60:
        return "D"
    else:
        return "Fail" if marks < 100 else "Score higher than 100"


def main():
    mark = int(input("What is your mark? "))
    print(marks(mark))


main()
