def traffic_light(color: str) -> None:
    match color.lower():
        case "red":
            print("Stop!")
        case "yellow":
            print("Get Ready")
        case "green":
            print("Go")
        case _:
            print("Invalid color")


color = input("What is the traffic light color: ")

traffic_light(color)
