def check_word(word: str, check: str) -> None:
    count = word.count(check)
    if count != 0:
        print(f"The word appears {count} times!")
        print("The first index of the word is at: " + str(word.index(check)))
    else:
        raise Exception("Word Not Found!")


check_word("Python is fun and Python is powerful", "aaaaaa")
