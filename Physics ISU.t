%Physics Program
%http://jupiterscientific.org/sciinfo/jokes/physicsjokes.html
setscreen ("graphics:max;max,nobuttonbar,offscreenonly")

const Ball_Num := 100
var chars : array char of boolean
var qui : boolean
var font : array 1 .. 10 of int
var randomcolour : int
var cont : string (1)
var random, count : int
var ballx, ballxspeed, bally, ballyspeed : array 1 .. Ball_Num of real
var ballcolour : array 1 .. Ball_Num of int
var ballhere : array 1 .. Ball_Num of boolean
for i : 1 .. Ball_Num
    ballhere (i) := true
    ballcolour (i) := Rand.Int (1, 255)
    ballyspeed (i) := Rand.Int (-15, -10)
    ballx (i) := Rand.Int (0, maxx)
    bally (i) := Rand.Int (maxy div 2, maxy)
    ballxspeed (i) := Rand.Int (-10, 10)
end for
font (1) := Font.New ("Arial:30")
font (3) := Font.New ("Arial:20")
font (2) := Font.New ("Arial:5")
font (4) := Font.New ("Arial:12")
count := 0
ballx (1) := 0
ballx (2) := maxx
ballx (3) := maxx div 2
bally (1) := maxy - (maxy div 3)
bally (2) := maxy div 2
bally (3) := maxy
loop
    cls
    Input.KeyDown (chars)
    Font.Draw ("Welcome To Physics Fun Time!", maxx div 3, maxy div 2, font (1), red)
    for i : 1 .. Ball_Num
	if ballhere (i) = true then
	    drawfilloval (round (ballx (i)), round (bally (i)), maxx div 100, maxx div 100, ballcolour (i))
	    if bally (i) <= 0 then
		ballyspeed (i) := -ballyspeed (i) * 0.8
		random := Rand.Int (0, 3)
		if random = 0 then
		    ballhere (i) := false
		    count += 1
		end if
	    end if
	end if
    end for
    for i : 1 .. Ball_Num
	if ballhere (i) = true then
	    ballx (i) += ballxspeed (i)
	    if ballx (i) > maxx or ballx (i) < 0 then
		ballxspeed (i) := -1 * ballxspeed (i)
	    end if
	    bally (i) += ballyspeed (i)
	    if ballyspeed (i) not= 0 then
		ballyspeed (i) := ballyspeed (i) - 4.9
	    end if
	end if
    end for
    delay (15 * Ball_Num div 30)
    View.Update
    exit when count = Ball_Num
    if chars (KEY_UP_ARROW) then
	exit
    end if
end loop
cls
Font.Draw ("MENU", maxx div 2 - (maxx div 15), maxy div 2, font (1), red)
var hold : int := maxy div 20

var mx, my, b : int
var choice : int
var Menu_Choice : array 1 .. 4 of
    record
	Name : string
	Num, x, y : int
    end record
Menu_Choice (4).Name := "Zorgs Adventure"
Menu_Choice (2).Name := "Exit"
Menu_Choice (3).Name := "Hoop Dreams"
Menu_Choice (1).Name := "Redo Opening?"

%arch
var Snow : array 1 .. 350 of
    record
	X, Y, X_Speed, Y_Speed : int
    end record
var P_X, P_Y, Angle, Ball_Mass, BallHeight, Spring_k : int
var Ball_Charge, move, move2 : boolean := false
var Place_Mode : boolean := false
var B_X, B_Y : real
var Balloon_X, Balloon_Y : int
var Bow_Angle, Angle2, Angle3 : real
var Speed, Speed_X, Speed_Y : real
var Charge_Ball_X, Charge_Ball_Y : real
var Charge_Ball_Charge : boolean
var Cooldown : boolean
var Win : boolean := false
var Test_Delay : int := 10
%Charge postive = true, false = negative charge
var Spring_X, Spring_Y : real
%zorg
const Max_Star := 300
var Zorg_X, Zorg_Y : real
var Garbage : array 1 .. 20 of
    record
	Sun_Angle : real
	X, Y : real
	X_Speed, Y_Speed : real
	Here : boolean
	Mass : int
    end record
var Zorg_Angle : real
var Ratio_X, Ratio_Y, Ratio : real
var Zorg_X_Velocity, Zorg_Y_Velocity : real
var Checkpoint_X, Checkpoint_Y, Zorg_Fuel, Zorg_Mass : int
var Star_X, Star_Y : array 1 .. Max_Star of int
var Sun_X, Sun_Y : int
var Sun_Angle : real
for i : 1 .. Max_Star
    Star_X (i) := Rand.Int (1, maxx)
    Star_Y (i) := Rand.Int (1, maxy)
end for
choice := 0
for i : 1 .. 4
    Menu_Choice (i).Num := i
    Menu_Choice (i).y := hold
    if i mod 2 not= 0 then
	Menu_Choice (i).x := maxx div 4
    else
	Menu_Choice (i).x := maxx div 2
	hold += maxy div 4
    end if
end for
for i : 1 .. 350
    Snow (i).X := Rand.Int (0, maxx)
    Snow (i).Y := maxy
    Snow (i).X_Speed := Rand.Int (-5, 5)
    Snow (i).Y_Speed := Rand.Int (-5, 5)
end for
View.Update
Win := false
loop
    colourback (white)
    loop
	cls
	choice := 0
	qui := false
	mousewhere (mx, my, b)
	Font.Draw ("Physics Fun Time", maxx div 2 - maxx div 7, maxy - maxy div 4, font (1), red)
	for i : 1 .. 4
	    Font.Draw (Menu_Choice (i).Name, Menu_Choice (i).x + maxx div 26, Menu_Choice (i).y + maxy div 14, font (3), red)
	    drawbox (Menu_Choice (i).x, Menu_Choice (i).y, Menu_Choice (i).x + maxx div 5, Menu_Choice (i).y + maxy div 6, red)
	    if mx > Menu_Choice (i).x and mx < Menu_Choice (i).x + maxx div 5 and my > Menu_Choice (i).y and my < Menu_Choice (i).y + maxy div 6 and b = 1 then
		choice := Menu_Choice (i).Num
	    end if
	end for
	View.Update
	exit when choice > 0
    end loop
    if choice = 4 then
	cls
	put "Welcome to Zorgs Adventure!"
	put "In this minigame you are zorg, and you are so far through the evolutionary stage that you are now able to exert force in any direction"
	put "Because you are tired of being better then everyone, you decide to leave Earth in search of a new Planet"
	put "The objective of the game is to travel through space from checkpoint to checkpoint while under a fuel limit."
	put "As you use fuel, your velocity will increase in that direction because of conservation of momentum"
	put "i.e p = m * v, you lose mass so to conserve momentum you increase velocity in the given direction."
	put "1 unit of fuel is expelled at a speed of 10 m/s opposite the angle of Zorg"
	put "Change angle using the mouse in relation to zorg, Use fuel using the Up arrow"
	put "Be Warned, in the later levels, there will be garbage that will collide and stick with you, affecting your speed"
	put "and there will also a Sun placed that if touched will end the game."
	put "This Sun will also exert force on Zorg"
	put "To reset the level, press the 'P' key"
	View.Update
	colourback (black)
	getch (cont)
	cls
	Font.Draw ("Level 1", maxx div 2, maxy div 2, font (1), red)
	View.Update
	getch (cont)
	Checkpoint_Y := maxy - maxy div 14
	Checkpoint_X := maxx div 2
	Zorg_Fuel := 100
	Zorg_Mass := 150
	Zorg_Angle := 0
	Zorg_X := maxx div 2
	Zorg_Y := maxy div 14
	Zorg_X_Velocity := 0
	Zorg_Y_Velocity := 0
	Cooldown := false
	loop
	    cls
	    mousewhere (mx, my, b)
	    Input.KeyDown (chars)
	    for i : 1 .. Max_Star
		drawdot (Star_X (i), Star_Y (i), white)
	    end for
	    if b = 1 and mx not= round (Zorg_X) and my not= round (Zorg_Y) then
		Zorg_Angle := abs (arctand (abs (Zorg_Y - my) / abs (Zorg_X - mx)))
		if mx > Zorg_X and my > Zorg_Y then
		    Zorg_Angle := (Zorg_Angle)
		elsif mx > Zorg_X and my < Zorg_Y then
		    Zorg_Angle := 360 - Zorg_Angle
		elsif mx < Zorg_X and my < Zorg_Y then
		    Zorg_Angle := 180 + Zorg_Angle
		else
		    Zorg_Angle := 180 - Zorg_Angle
		end if
	    end if
	    if chars ('p') and Cooldown = false then
		Cooldown := true
		Zorg_X := maxx div 2
		Zorg_Y := maxy div 14
		Zorg_X_Velocity := 0
		Zorg_Y_Velocity := 0
		Zorg_Fuel := 100
	    end if
	    if chars (KEY_UP_ARROW) and Zorg_Fuel > 0 and Cooldown = false then
		Zorg_Fuel -= 1
		Zorg_Mass -= 1
		Zorg_X_Velocity += cosd (Zorg_Angle) / Zorg_Mass
		Zorg_Y_Velocity += sind (Zorg_Angle) / Zorg_Mass
		Cooldown := true
	    end if
	    if chars ('z') then
		qui := true
		exit
	    end if
	    drawline (round (Zorg_X), round (Zorg_Y), cosd (Zorg_Angle) * maxy div 25 + round (Zorg_X), round (Zorg_Y) + sind (Zorg_Angle) * maxy div 25, red)
	    drawfilloval (Checkpoint_X, Checkpoint_Y, maxy div 50, maxy div 50, white)
	    drawfilloval (round (Zorg_X), round (Zorg_Y), maxy div 50, maxy div 50, red)
	    drawfillbox (maxx, maxy, maxx - maxx div 7, maxy - maxy div 10, white)
	    Font.Draw ("Fuel: " + intstr (Zorg_Fuel), maxx - maxx div 10, maxy - maxy div 50, font (4), red)
	    Font.Draw ("Mass: " + intstr (Zorg_Mass), maxx - maxx div 10, maxy - maxy div 25, font (4), red)
	    Font.Draw ("Angle: " + realstr (Zorg_Angle, 5), maxx - maxx div 10, maxy - (maxy div 17), font (4), red)
	    Font.Draw ("X Velocity: " + realstr (Zorg_X_Velocity, 2), maxx - maxx div 8, maxy - maxy div 13, font (4), red)
	    Font.Draw ("Y Velocity: " + realstr (Zorg_Y_Velocity, 2), maxx - maxx div 8, maxy - maxy div 11, font (4), red)
	    if chars (KEY_UP_ARROW) = false and chars ('p') = false then
		Cooldown := false
	    end if
	    Zorg_X += Zorg_X_Velocity
	    Zorg_Y += Zorg_Y_Velocity
	    View.Update
	    exit when Math.Distance (Zorg_X, Zorg_Y, Checkpoint_X, Checkpoint_Y) <= (maxy div 50) * 2
	end loop

	if qui not= true then
	    Font.Draw ("Level 1 Complete!", maxx div 3, maxy - maxy div 3, font (1), red)
	    View.Update
	    getch (cont)
	    cls
	    Font.Draw ("Level 2", maxx div 2, maxy div 2, font (1), red)
	    Checkpoint_Y := maxy - maxy div 14
	    Checkpoint_X := maxx div 2
	    Zorg_Fuel := 100
	    Zorg_Mass := 150
	    Zorg_Angle := 0
	    Zorg_X := maxx div 2
	    Zorg_Y := maxy div 14
	    Zorg_X_Velocity := 0
	    Zorg_Y_Velocity := 0
	    Cooldown := false
	    for i : 1 .. 5
		Garbage (i).X := Rand.Int (0, maxx)
		Garbage (i).Y := Rand.Int (0, maxy)
		Garbage (i).Here := true
		Garbage (i).Mass := maxy div 75
		loop
		    Garbage (i).X_Speed := Rand.Real * Rand.Int (-2, 2)
		    Garbage (i).Y_Speed := Rand.Real * Rand.Int (-2, 2)
		    exit when Garbage (i).X_Speed not= 0 and Garbage (i).Y_Speed not= 0
		end loop
	    end for
	    View.Update
	    getch (cont)
	    loop
		cls
		if chars ('z') then
		    qui := true
		    exit
		end if
		mousewhere (mx, my, b)
		Input.KeyDown (chars)
		for i : 1 .. Max_Star
		    drawdot (Star_X (i), Star_Y (i), white)
		end for
		for i : 1 .. 5
		    if Math.Distance (Garbage (i).X, Garbage (i).Y, Zorg_X, Zorg_Y) <= Garbage (i).Mass + maxy div 50 and Garbage (i).Here = true then
			Garbage (i).Here := false
			Zorg_X_Velocity := (((Garbage (i).X_Speed * Garbage (i).Mass) + (Zorg_Mass * Zorg_X_Velocity)) / (Garbage (i).Mass + Zorg_Mass))
			Zorg_Y_Velocity := (((Garbage (i).Y_Speed * Garbage (i).Mass) + (Zorg_Mass * Zorg_Y_Velocity)) / (Garbage (i).Mass + Zorg_Mass))
			Zorg_Mass := Garbage (i).Mass + Zorg_Mass
		    end if
		    for c : 1 .. 5
			if c not= i then
			    if Math.Distance (Garbage (i).X, Garbage (i).Y, Garbage (c).X, Garbage (c).Y) <= Garbage (i).Mass + Garbage (c).Mass and Garbage (i).Here = true and Garbage (c).Here = true
				    then
				Garbage (c).Here := false
				Garbage (i).X_Speed := (((Garbage (i).X_Speed * Garbage (i).Mass) + (Garbage (c).X_Speed * Garbage (c).Mass)) / (Garbage (i).Mass + Garbage (c).Mass))
				Garbage (i).Y_Speed := (((Garbage (i).Y_Speed * Garbage (i).Mass) + (Garbage (c).Y_Speed * Garbage (c).Mass)) / (Garbage (i).Mass + Garbage (c).Mass))
				Garbage (i).Mass := Garbage (i).Mass + Garbage (c).Mass
			    end if
			end if
		    end for

		    if Garbage (i).Here = true then
			drawfilloval (round (Garbage (i).X), round (Garbage (i).Y), Garbage (i).Mass, Garbage (i).Mass, green)
			Garbage (i).X += Garbage (i).X_Speed
			Garbage (i).Y += Garbage (i).Y_Speed
			if Garbage (i).X > maxx or Garbage (i).X < 0 then
			    Garbage (i).X_Speed := -Garbage (i).X_Speed
			end if
			if Garbage (i).Y > maxy or Garbage (i).Y < 0 then
			    Garbage (i).Y_Speed := -Garbage (i).Y_Speed
			end if
		    end if
		end for

		if b = 1 and mx not= round (Zorg_X) and my not= round (Zorg_Y) then
		    Zorg_Angle := abs (arctand (abs (Zorg_Y - my) / abs (Zorg_X - mx)))
		    if mx > Zorg_X and my > Zorg_Y then
			Zorg_Angle := (Zorg_Angle)
		    elsif mx > Zorg_X and my < Zorg_Y then
			Zorg_Angle := 360 - Zorg_Angle
		    elsif mx < Zorg_X and my < Zorg_Y then
			Zorg_Angle := 180 + Zorg_Angle
		    else
			Zorg_Angle := 180 - Zorg_Angle
		    end if
		end if
		if chars ('p') and Cooldown = false then
		    Cooldown := true
		    Zorg_X := maxx div 2
		    Zorg_Y := maxy div 14
		    Zorg_X_Velocity := 0
		    Zorg_Y_Velocity := 0
		    Zorg_Fuel := 100
		    for i : 1 .. 5
			Garbage (i).X := Rand.Int (0, maxx)
			Garbage (i).Y := Rand.Int (0, maxy)
			Garbage (i).Here := true
			Garbage (i).Mass := maxy div 75
			loop
			    Garbage (i).X_Speed := Rand.Real * Rand.Int (-2, 2)
			    Garbage (i).Y_Speed := Rand.Real * Rand.Int (-2, 2)
			    exit when Garbage (i).X_Speed not= 0 and Garbage (i).Y_Speed not= 0
			end loop
		    end for
		end if
		if chars (KEY_UP_ARROW) and Zorg_Fuel > 0 and Cooldown = false then
		    Zorg_Fuel -= 1
		    Zorg_Mass -= 1
		    Zorg_X_Velocity += cosd (Zorg_Angle) / (Zorg_Mass)
		    Zorg_Y_Velocity += sind (Zorg_Angle) / (Zorg_Mass)
		    Cooldown := true
		end if
		drawline (round (Zorg_X), round (Zorg_Y), cosd (Zorg_Angle) * maxy div 25 + round (Zorg_X), round (Zorg_Y) + sind (Zorg_Angle) * maxy div 25, red)
		drawfilloval (Checkpoint_X, Checkpoint_Y, maxy div 50, maxy div 50, white)
		drawfilloval (round (Zorg_X), round (Zorg_Y), maxy div 50, maxy div 50, red)
		drawfillbox (maxx, maxy, maxx - maxx div 7, maxy - maxy div 10, white)
		Font.Draw ("Fuel: " + intstr (Zorg_Fuel), maxx - maxx div 10, maxy - maxy div 50, font (4), red)
		Font.Draw ("Mass: " + intstr (Zorg_Mass), maxx - maxx div 10, maxy - maxy div 25, font (4), red)
		Font.Draw ("Angle: " + realstr (Zorg_Angle, 5), maxx - maxx div 10, maxy - (maxy div 17), font (4), red)
		Font.Draw ("X Velocity: " + realstr (Zorg_X_Velocity, 2), maxx - maxx div 8, maxy - maxy div 13, font (4), red)
		Font.Draw ("Y Velocity: " + realstr (Zorg_Y_Velocity, 2), maxx - maxx div 8, maxy - maxy div 11, font (4), red)
		if chars (KEY_UP_ARROW) = false and chars ('p') = false then
		    Cooldown := false
		end if
		Zorg_X += Zorg_X_Velocity
		Zorg_Y += Zorg_Y_Velocity
		View.Update
		exit when Math.Distance (Zorg_X, Zorg_Y, Checkpoint_X, Checkpoint_Y) <= (maxy div 50) * 2
	    end loop

	end if
	if qui not= true then
	    Font.Draw ("Level 2 Complete!", maxx div 3, maxy - maxy div 3, font (1), red)
	    View.Update
	    getch (cont)
	    cls
	    Font.Draw ("Level 3", maxx div 2, maxy div 2, font (1), red)
	    Checkpoint_Y := maxy - maxy div 14
	    Checkpoint_X := maxy div 25
	    Zorg_Fuel := 100
	    Zorg_Mass := 150
	    Zorg_Angle := 0
	    Zorg_X := maxx div 2
	    Zorg_Y := maxy div 14
	    Zorg_X_Velocity := 0
	    Zorg_Y_Velocity := 0
	    Cooldown := false
	    for i : 1 .. 15
		Garbage (i).X := Rand.Int (0, maxx)
		Garbage (i).Y := Rand.Int (0, maxy)
		Garbage (i).Here := true
		Garbage (i).Mass := maxy div 75
		loop
		    Garbage (i).X_Speed := Rand.Real * Rand.Int (-2, 2)
		    Garbage (i).Y_Speed := Rand.Real * Rand.Int (-2, 2)
		    exit when Garbage (i).X_Speed not= 0 and Garbage (i).Y_Speed not= 0
		end loop
	    end for
	    View.Update
	    getch (cont)
	    loop
		cls

		mousewhere (mx, my, b)
		Input.KeyDown (chars)
		for i : 1 .. Max_Star
		    drawdot (Star_X (i), Star_Y (i), white)
		end for
		if chars ('z') then
		    qui := true
		    exit
		end if
		for i : 1 .. 15
		    if Math.Distance (Garbage (i).X, Garbage (i).Y, Zorg_X, Zorg_Y) <= Garbage (i).Mass + maxy div 50 and Garbage (i).Here = true then
			Garbage (i).Here := false
			Zorg_X_Velocity := (((Garbage (i).X_Speed * Garbage (i).Mass) + (Zorg_Mass * Zorg_X_Velocity)) / (Garbage (i).Mass + Zorg_Mass))
			Zorg_Y_Velocity := (((Garbage (i).Y_Speed * Garbage (i).Mass) + (Zorg_Mass * Zorg_Y_Velocity)) / (Garbage (i).Mass + Zorg_Mass))
			Zorg_Mass := Garbage (i).Mass + Zorg_Mass
		    end if
		    for c : 1 .. 15
			if c not= i then
			    if Math.Distance (Garbage (i).X, Garbage (i).Y, Garbage (c).X, Garbage (c).Y) <= Garbage (i).Mass + Garbage (c).Mass and Garbage (i).Here = true and Garbage (c).Here = true
				    then
				Garbage (c).Here := false
				Garbage (i).X_Speed := (((Garbage (i).X_Speed * Garbage (i).Mass) + (Garbage (c).X_Speed * Garbage (c).Mass)) / (Garbage (i).Mass + Garbage (c).Mass))
				Garbage (i).Y_Speed := (((Garbage (i).Y_Speed * Garbage (i).Mass) + (Garbage (c).Y_Speed * Garbage (c).Mass)) / (Garbage (i).Mass + Garbage (c).Mass))
				Garbage (i).Mass := Garbage (i).Mass + Garbage (c).Mass
			    end if
			end if
		    end for
		    if Garbage (i).Here = true then
			drawfilloval (round (Garbage (i).X), round (Garbage (i).Y), Garbage (i).Mass, Garbage (i).Mass, green)
			Garbage (i).X += Garbage (i).X_Speed
			Garbage (i).Y += Garbage (i).Y_Speed
			if Garbage (i).X > maxx or Garbage (i).X < 0 then
			    Garbage (i).X_Speed := -Garbage (i).X_Speed
			end if
			if Garbage (i).Y > maxy or Garbage (i).Y < 0 then
			    Garbage (i).Y_Speed := -Garbage (i).Y_Speed
			end if
		    end if
		end for
		if b = 1 and mx not= round (Zorg_X) and my not= round (Zorg_Y) then
		    Zorg_Angle := abs (arctand (abs (Zorg_Y - my) / abs (Zorg_X - mx)))
		    if mx > Zorg_X and my > Zorg_Y then
			Zorg_Angle := (Zorg_Angle)
		    elsif mx > Zorg_X and my < Zorg_Y then
			Zorg_Angle := 360 - Zorg_Angle
		    elsif mx < Zorg_X and my < Zorg_Y then
			Zorg_Angle := 180 + Zorg_Angle
		    else
			Zorg_Angle := 180 - Zorg_Angle
		    end if
		end if
		if chars ('p') and Cooldown = false then
		    Cooldown := true
		    Zorg_X := maxx div 2
		    Zorg_Y := maxy div 14
		    Zorg_X_Velocity := 0
		    Zorg_Y_Velocity := 0
		    Zorg_Fuel := 100
		    for i : 1 .. 15
			Garbage (i).X := Rand.Int (0, maxx)
			Garbage (i).Y := Rand.Int (0, maxy)
			Garbage (i).Here := true
			Garbage (i).Mass := maxy div 75
			loop
			    Garbage (i).X_Speed := Rand.Real * Rand.Int (-2, 2)
			    Garbage (i).Y_Speed := Rand.Real * Rand.Int (-2, 2)
			    exit when Garbage (i).X_Speed not= 0 and Garbage (i).Y_Speed not= 0
			end loop
		    end for
		end if
		if chars (KEY_UP_ARROW) and Zorg_Fuel > 0 and Cooldown = false then
		    Zorg_Fuel -= 1
		    Zorg_Mass -= 1
		    Zorg_X_Velocity += cosd (Zorg_Angle) / Zorg_Mass
		    Zorg_Y_Velocity += sind (Zorg_Angle) / Zorg_Mass
		    Cooldown := true
		end if
		drawline (round (Zorg_X), round (Zorg_Y), cosd (Zorg_Angle) * maxy div 25 + round (Zorg_X), round (Zorg_Y) + sind (Zorg_Angle) * maxy div 25, red)
		drawfilloval (Checkpoint_X, Checkpoint_Y, maxy div 50, maxy div 50, white)
		drawfilloval (round (Zorg_X), round (Zorg_Y), maxy div 50, maxy div 50, red)
		drawfillbox (maxx, maxy, maxx - maxx div 7, maxy - maxy div 10, white)
		Font.Draw ("Fuel: " + intstr (Zorg_Fuel), maxx - maxx div 10, maxy - maxy div 50, font (4), red)
		Font.Draw ("Mass: " + intstr (Zorg_Mass), maxx - maxx div 10, maxy - maxy div 25, font (4), red)
		Font.Draw ("Angle: " + realstr (Zorg_Angle, 5), maxx - maxx div 10, maxy - (maxy div 17), font (4), red)
		Font.Draw ("X Velocity: " + realstr (Zorg_X_Velocity, 2), maxx - maxx div 8, maxy - maxy div 13, font (4), red)
		Font.Draw ("Y Velocity: " + realstr (Zorg_Y_Velocity, 2), maxx - maxx div 8, maxy - maxy div 11, font (4), red)
		if chars (KEY_UP_ARROW) = false and chars ('p') = false then
		    Cooldown := false
		end if
		Zorg_X += Zorg_X_Velocity
		Zorg_Y += Zorg_Y_Velocity
		View.Update
		exit when Math.Distance (Zorg_X, Zorg_Y, Checkpoint_X, Checkpoint_Y) <= (maxy div 50) * 2
	    end loop

	end if
	loop

	    exit when qui = true
	    Font.Draw ("Level 3 Complete!", maxx div 3, maxy - maxy div 3, font (1), red)
	    View.Update
	    getch (cont)
	    cls
	    Font.Draw ("Level 4", maxx div 2, maxy div 2, font (1), red)
	    Checkpoint_Y := maxy - maxy div 14
	    Checkpoint_X := maxx div 2
	    Zorg_Fuel := 100
	    Zorg_Mass := 150
	    Zorg_Angle := 0
	    Zorg_X := maxx div 2
	    Zorg_Y := maxy div 14
	    Zorg_X_Velocity := 0
	    Zorg_Y_Velocity := 0
	    Cooldown := false
	    Sun_X := maxx div 2
	    Sun_Y := maxy div 2
	    for i : 1 .. 15
		Garbage (i).X := Rand.Int (0, maxx)
		Garbage (i).Y := Rand.Int (0, maxy)
		Garbage (i).Here := true
		Garbage (i).Mass := maxy div 75
		loop
		    Garbage (i).X_Speed := Rand.Real * Rand.Int (-2, 2)
		    Garbage (i).Y_Speed := Rand.Real * Rand.Int (-2, 2)
		    exit when Garbage (i).X_Speed not= 0 and Garbage (i).Y_Speed not= 0
		end loop
	    end for
	    View.Update
	    getch (cont)
	    loop
		cls
		mousewhere (mx, my, b)
		Input.KeyDown (chars)
		for i : 1 .. Max_Star
		    drawdot (Star_X (i), Star_Y (i), white)
		end for
		for i : 1 .. 15
		    if Math.Distance (Garbage (i).X, Garbage (i).Y, Zorg_X, Zorg_Y) <= Garbage (i).Mass + maxy div 50 and Garbage (i).Here = true then
			Garbage (i).Here := false
			Zorg_X_Velocity := (((Garbage (i).X_Speed * Garbage (i).Mass) + (Zorg_Mass * Zorg_X_Velocity)) / (Garbage (i).Mass + Zorg_Mass))
			Zorg_Y_Velocity := (((Garbage (i).Y_Speed * Garbage (i).Mass) + (Zorg_Mass * Zorg_Y_Velocity)) / (Garbage (i).Mass + Zorg_Mass))
			Zorg_Mass := Garbage (i).Mass + Zorg_Mass
		    end if
		    for c : 1 .. 15
			if c not= i then
			    if Math.Distance (Garbage (i).X, Garbage (i).Y, Garbage (c).X, Garbage (c).Y) <= Garbage (i).Mass + Garbage (c).Mass and Garbage (i).Here = true and Garbage (c).Here =
				    true
				    then
				Garbage (c).Here := false
				Garbage (i).X_Speed := (((Garbage (i).X_Speed * Garbage (i).Mass) + (Garbage (c).X_Speed * Garbage (c).Mass)) / (Garbage (i).Mass + Garbage (c).Mass))
				Garbage (i).Y_Speed := (((Garbage (i).Y_Speed * Garbage (i).Mass) + (Garbage (c).Y_Speed * Garbage (c).Mass)) / (Garbage (i).Mass + Garbage (c).Mass))
				Garbage (i).Mass := Garbage (i).Mass + Garbage (c).Mass
			    end if
			end if

		    end for
		    if Math.Distance (Sun_X, Sun_Y, Garbage (i).X, Garbage (i).Y) <= (maxy div 15) * 4 then
			Garbage (i).Sun_Angle := abs (arctand (abs (Garbage (i).Y - Sun_Y) / abs (Garbage (i).X - Sun_X)))
			if Garbage (i).X < Sun_X and Garbage (i).Y < Sun_Y then
			    Garbage (i).Sun_Angle := Garbage (i).Sun_Angle
			elsif Garbage (i).X < Sun_X and Garbage (i).Y > Sun_Y then
			    Garbage (i).Sun_Angle := 360 - Garbage (i).Sun_Angle
			elsif Garbage (i).X > Sun_X and Garbage (i).Y > Sun_Y then
			    Garbage (i).Sun_Angle := 180 + Garbage (i).Sun_Angle
			else
			    Garbage (i).Sun_Angle := 180 - Garbage (i).Sun_Angle
			end if
			Garbage (i).X_Speed += cosd (Garbage (i).Sun_Angle) / (Garbage (i).Mass * Math.Distance (Sun_X, Sun_Y, Garbage (i).X, Garbage (i).Y) / 10)
			Garbage (i).Y_Speed += sind (Garbage (i).Sun_Angle) / (Garbage (i).Mass * Math.Distance (Sun_X, Sun_Y, Garbage (i).X, Garbage (i).Y) / 10)
		    end if
		    if Garbage (i).Here = true then
			drawfilloval (round (Garbage (i).X), round (Garbage (i).Y), Garbage (i).Mass, Garbage (i).Mass, green)
			Garbage (i).X += Garbage (i).X_Speed
			Garbage (i).Y += Garbage (i).Y_Speed
			if Garbage (i).X > maxx or Garbage (i).X < 0 then
			    Garbage (i).X_Speed := -Garbage (i).X_Speed
			end if
			if Garbage (i).Y > maxy or Garbage (i).Y < 0 then
			    Garbage (i).Y_Speed := -Garbage (i).Y_Speed
			end if
		    end if
		end for
		if b = 1 and mx not= round (Zorg_X) and my not= round (Zorg_Y) then
		    Zorg_Angle := abs (arctand (abs (Zorg_Y - my) / abs (Zorg_X - mx)))
		    if mx > Zorg_X and my > Zorg_Y then
			Zorg_Angle := (Zorg_Angle)
		    elsif mx > Zorg_X and my < Zorg_Y then
			Zorg_Angle := 360 - Zorg_Angle
		    elsif mx < Zorg_X and my < Zorg_Y then
			Zorg_Angle := 180 + Zorg_Angle
		    else
			Zorg_Angle := 180 - Zorg_Angle
		    end if
		end if
		if chars ('z') then
		    qui := true
		    exit
		end if
		if chars ('p') and Cooldown = false then
		    Cooldown := true
		    Zorg_X := maxx div 2
		    Zorg_Y := maxy div 14
		    Zorg_X_Velocity := 0
		    Zorg_Y_Velocity := 0
		    Zorg_Fuel := 100
		    for i : 1 .. 15
			Garbage (i).X := Rand.Int (0, maxx)
			Garbage (i).Y := Rand.Int (0, maxy)
			Garbage (i).Here := true
			Garbage (i).Mass := maxy div 75
			loop
			    Garbage (i).X_Speed := Rand.Real * Rand.Int (-2, 2)
			    Garbage (i).Y_Speed := Rand.Real * Rand.Int (-2, 2)
			    exit when Garbage (i).X_Speed not= 0 and Garbage (i).Y_Speed not= 0
			end loop
		    end for
		end if
		if chars (KEY_UP_ARROW) and Zorg_Fuel > 0 and Cooldown = false then
		    Zorg_Fuel -= 1
		    Zorg_Mass -= 1
		    Zorg_X_Velocity += cosd (Zorg_Angle) / Zorg_Mass
		    Zorg_Y_Velocity += sind (Zorg_Angle) / Zorg_Mass
		    Cooldown := true
		end if
		drawfilloval (Sun_X, Sun_Y, maxy div 15, maxy div 15, red)
		drawoval (Sun_X, Sun_Y, (maxy div 15) * 4, (maxy div 15) * 4, red)
		if Math.Distance (Sun_X, Sun_Y, Zorg_X, Zorg_Y) <= (maxy div 15) * 4 then
		    Sun_Angle := abs (arctand (abs (Zorg_Y - Sun_Y) / abs (Zorg_X - Sun_X)))
		    if Zorg_X < Sun_X and Zorg_Y < Sun_Y then
			Sun_Angle := (Sun_Angle)
		    elsif Zorg_X < Sun_X and Zorg_Y > Sun_Y then
			Sun_Angle := 360 - Sun_Angle
		    elsif Zorg_X > Sun_X and Zorg_Y > Sun_Y then
			Sun_Angle := 180 + Sun_Angle
		    else
			Sun_Angle := 180 - Sun_Angle
		    end if
		    Zorg_X_Velocity += cosd (Sun_Angle) / (Zorg_Mass * Math.Distance (Sun_X, Sun_Y, Zorg_X, Zorg_Y) / 10)
		    Zorg_Y_Velocity += sind (Sun_Angle) / (Zorg_Mass * Math.Distance (Sun_X, Sun_Y, Zorg_X, Zorg_Y) / 10)
		end if
		if Math.Distance (Sun_X, Sun_Y, Zorg_X, Zorg_Y) <= maxy div 15 + maxy div 50 then
		    Win := false
		    exit
		end if
		drawline (round (Zorg_X), round (Zorg_Y), cosd (Zorg_Angle) * maxy div 25 + round (Zorg_X), round (Zorg_Y) + sind (Zorg_Angle) * maxy div 25, red)
		drawfilloval (Checkpoint_X, Checkpoint_Y, maxy div 50, maxy div 50, white)
		drawfilloval (round (Zorg_X), round (Zorg_Y), maxy div 50, maxy div 50, red)
		drawfillbox (maxx, maxy, maxx - maxx div 7, maxy - maxy div 10, white)
		Font.Draw ("Fuel: " + intstr (Zorg_Fuel), maxx - maxx div 10, maxy - maxy div 50, font (4), red)
		Font.Draw ("Mass: " + intstr (Zorg_Mass), maxx - maxx div 10, maxy - maxy div 25, font (4), red)
		Font.Draw ("Angle: " + realstr (Zorg_Angle, 5), maxx - maxx div 10, maxy - (maxy div 17), font (4), red)
		Font.Draw ("X Velocity: " + realstr (Zorg_X_Velocity, 2), maxx - maxx div 8, maxy - maxy div 13, font (4), red)
		Font.Draw ("Y Velocity: " + realstr (Zorg_Y_Velocity, 2), maxx - maxx div 8, maxy - maxy div 11, font (4), red)
		if chars (KEY_UP_ARROW) = false and chars ('p') = false then
		    Cooldown := false
		end if
		Zorg_X += Zorg_X_Velocity
		Zorg_Y += Zorg_Y_Velocity
		View.Update
		if Math.Distance (Zorg_X, Zorg_Y, Checkpoint_X, Checkpoint_Y) <= (maxy div 50) * 2 then
		    Win := true
		    exit
		end if
	    end loop
	    exit when Win = true
	end loop
	if qui not= true then
	    Font.Draw ("Level 4 Complete!", maxx div 3, maxy - maxy div 3, font (1), red)
	    View.Update
	    getch (cont)
	    cls
	    Font.Draw ("You Win!", maxx div 2, maxy - maxy div 3, font (1), red)
	    View.Update
	    getch (cont)
	end if
    elsif choice = 2 then
	quit
    elsif choice = 3 then
	cls
	put "Welcome to the Target Minigame!"
	put "In thie minigame, you will be a stick character throwing a ball that can carry a charge at a balloon because you are a menace to society!"
	put "The minigame is set on Earth so use your physics knowledge to hit the balloon!"
	put "A tennis ball has approximate coefficient of restitution of 0.75"
	put "To help complete your goal, you have a moveable bounce ball and another moveable charged ball"
	put "The 'C' key changes the charge the moveable ball, and v controls the charge of your ball"
	put "When there is a collsion between the bounce ball and the thrown ball,"
	put "there will be a completely elastic collsion in which the bounce ball will not move i.e the ball will keep is original speed just in a new direction"
	put "Press p and click the bounce ball or the charge ball to move their position."
	put "Up Right is postive and the speed is in meters per second"
	View.Update
	getch (cont)
	cls
	Font.Draw ("Level 1", maxx div 2, maxy div 2, font (1), red)
	P_X := maxx - maxx div 10
	P_Y := maxy div 25
	Ball_Mass := 100
	Charge_Ball_X := maxx div 2
	Charge_Ball_Y := maxy div 2
	Balloon_X := maxx div 10
	Balloon_Y := maxy div 4
	Ball_Charge := true
	Charge_Ball_Charge := true
	Spring_X := maxx div 2
	Spring_Y := maxy div 50 * 2
	Cooldown := false
	move := false
	Win := false
	View.Update
	getch (cont)
	cls
	loop
	    colourback (black)
	    loop
		cls
		for i : 1 .. 350
		    drawdot (Snow (i).X, Snow (i).Y, white)
		    Snow (i).X += Snow (i).X_Speed
		    Snow (i).Y += Snow (i).Y_Speed
		    if Snow (i).X > maxx or Snow (i).X < 0 or Snow (i).Y < 0 then
			Snow (i).X := Rand.Int (0, maxx)
			Snow (i).Y := maxy
			Snow (i).X_Speed := Rand.Int (-5, 5)
			Snow (i).Y_Speed := Rand.Int (-5, 5)
		    end if
		end for
		mousewhere (mx, my, b)
		Input.KeyDown (chars)
		if chars ('z') then
		    qui := true
		    exit
		end if
		if mx = P_X then
		    Bow_Angle := -1000
		else
		    Bow_Angle := arctand (abs (my - (P_Y + maxy div 50)) / abs (mx - P_X))
		    if mx > P_X then
			B_X := P_X + (maxy div 50 * cosd (Bow_Angle))
			if my < P_Y then
			    B_Y := P_Y + maxy div 50 - (sind (Bow_Angle) * maxy div 50)
			else
			    B_Y := P_Y + maxy div 50 + (sind (Bow_Angle) * maxy div 50)
			end if
		    else
			B_X := P_X - (maxy div 50 * cosd (Bow_Angle))
			if my < P_Y then
			    B_Y := (P_Y + maxy div 50) - (sind (Bow_Angle) * maxy div 50)
			else
			    B_Y := (P_Y + maxy div 50) + (sind (Bow_Angle) * maxy div 50)
			end if
		    end if
		end if
		if Place_Mode = true then
		    if b = 1 and mx > Charge_Ball_X - Ball_Mass div 10 and mx < Charge_Ball_X + Ball_Mass div 10 and my > Charge_Ball_Y - Ball_Mass div 10 and my < Charge_Ball_Y + Ball_Mass
			    div 10
			    then
			move := true
		    end if
		    if move = true then
			Charge_Ball_X := mx
			Charge_Ball_Y := my
		    end if
		    if b = 0 then
			move := false
			move2 := false
		    end if
		    if b = 1 and mx > Spring_X - maxy div 50 and mx < Spring_X + maxy div 50 and my > Spring_Y and my < Spring_Y + maxy div 50 then
			move2 := true
		    end if
		    if move2 = true then
			Spring_X := mx
			Spring_Y := my
		    end if
		end if
		drawfillbox (0, 0, maxx, 0 + maxy div 50, green)
		drawfilloval (P_X, P_Y + maxy div 25, maxy div 75, maxy div 75, red)
		drawline (P_X, P_Y, P_X, P_Y + maxy div 25, red)
		drawline (P_X, P_Y, P_X - maxx div 75, P_Y - maxy div 50, red)
		drawline (P_X, P_Y, P_X + maxx div 75, P_Y - maxy div 50, red)
		if Place_Mode = false then
		    drawline (round (B_X), round (B_Y), mx, my, white)
		end if
		if chars ('q') then
		    Test_Delay += 10
		end if
		if chars ('w') and Test_Delay > 0 then
		    Test_Delay -= 10
		end if
		drawfilloval (round (Spring_X), round (Spring_Y), maxy div 75, maxy div 75, red)
		drawfilloval (round (B_X), round (B_Y), Ball_Mass div 10, Ball_Mass div 10, red)
		drawfilloval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass div 10, Ball_Mass div 10, red)
		drawline (round (Charge_Ball_X + Ball_Mass div 13), round (Charge_Ball_Y), round (Charge_Ball_X - Ball_Mass div 13), round (Charge_Ball_Y), white)
		drawoval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass, Ball_Mass, red)
		if Charge_Ball_Charge = true then
		    drawline (round (Charge_Ball_X), round (Charge_Ball_Y + Ball_Mass div 13), round (Charge_Ball_X), round (Charge_Ball_Y - Ball_Mass div 13), white)
		end if
		drawline (round (B_X + Ball_Mass div 13), round (B_Y), round (B_X - Ball_Mass div 13), round (B_Y), white)
		if Ball_Charge = true then
		    drawline (round (B_X), round (B_Y + Ball_Mass div 13), round (B_X), round (B_Y - Ball_Mass div 13), white)
		end if
		if chars ('p') and Cooldown = false then
		    if Place_Mode = true then
			Place_Mode := false
		    else
			Place_Mode := true
		    end if
		    Cooldown := true
		end if
		if chars ('v') and Cooldown = false then
		    if Ball_Charge = true then
			Ball_Charge := false
		    else
			Ball_Charge := true
		    end if
		    Cooldown := true
		end if
		if chars ('c') and Cooldown = false then
		    if Charge_Ball_Charge = true then
			Charge_Ball_Charge := false
		    else
			Charge_Ball_Charge := true
		    end if
		    Cooldown := true
		end if
		drawfilloval (Balloon_X, Balloon_Y, Ball_Mass div 2, Ball_Mass div 2, red)
		drawline (Balloon_X, Balloon_Y - Ball_Mass div 2, Balloon_X, Balloon_Y - Ball_Mass * 2, red)
		drawline (P_X, P_Y + maxy div 50, round (B_X), round (B_Y), red)
		if chars ('c') = false and chars ('v') = false and chars ('p') = false then
		    Cooldown := false
		end if
		Speed := Math.Distance (mx, my, B_X, B_Y) div 25
		if Bow_Angle not= -1000 then
		    if mx > P_X then
			Speed_X := cosd (Bow_Angle) * Speed
		    else
			Speed_X := - (cosd (Bow_Angle) * Speed)
		    end if
		    if my > P_Y + maxy div 50 then
			Speed_Y := sind (Bow_Angle) * Speed
		    else
			Speed_Y := - (sind (Bow_Angle) * Speed)
		    end if
		end if
		Font.Draw ("Speed: " + intstr (round (Speed)), maxx - maxx div 10, maxy - maxy div 25, font (4), red)
		if Place_Mode = false then
		    if Bow_Angle not= -1000 then
			Font.Draw ("Angle: " + intstr (round (Bow_Angle)), maxx - maxx div 10, maxy - maxy div 75, font (4), red)
		    else
			Font.Draw ("Angle: Undefined", maxx - maxx div 10, maxy - maxy div 75, font (4), red)
		    end if
		end if
		delay (Test_Delay)
		View.Update
		exit when b = 1 and Place_Mode = false
	    end loop
	    exit when qui = true
	    BallHeight := round (B_Y)
	    loop
		cls
		Input.KeyDown (chars)
		for i : 1 .. 350
		    drawdot (Snow (i).X, Snow (i).Y, white)
		    Snow (i).X += Snow (i).X_Speed
		    Snow (i).Y += Snow (i).Y_Speed
		    if Snow (i).X > maxx or Snow (i).X < 0 or Snow (i).Y < 0 then
			Snow (i).X := Rand.Int (0, maxx)
			Snow (i).Y := maxy
			Snow (i).X_Speed := Rand.Int (-5, 5)
			Snow (i).Y_Speed := Rand.Int (-5, 5)
		    end if
		end for
		drawfilloval (P_X, P_Y + maxy div 25, maxy div 75, maxy div 75, red)
		drawoval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass, Ball_Mass, red)
		drawfilloval (round (B_X), round (B_Y), Ball_Mass div 10, Ball_Mass div 10, red)
		drawfilloval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass div 10, Ball_Mass div 10, red)
		drawfilloval (Balloon_X, Balloon_Y, Ball_Mass div 2, Ball_Mass div 2, red)
		drawline (Balloon_X, Balloon_Y - Ball_Mass div 2, Balloon_X, Balloon_Y - Ball_Mass * 2, red)
		drawfilloval (round (Spring_X), round (Spring_Y), maxy div 75, maxy div 75, red)
		drawline (P_X, P_Y, P_X, P_Y + maxy div 25, red)
		drawline (P_X, P_Y, P_X - maxx div 75, P_Y - maxy div 50, red)
		drawline (P_X, P_Y, P_X + maxx div 75, P_Y - maxy div 50, red)
		Font.Draw ("Speed: " + intstr (round (Speed)), maxx - maxx div 10, maxy - maxy div 25, font (4), red)
		Font.Draw ("X Speed: " + intstr (round (Speed_X)), maxx - maxx div 10, maxy - ((maxy div 13) * 2), font (4), red)
		Font.Draw ("Y Speed: " + intstr (round (Speed_Y)), maxx - maxx div 10, maxy - ((maxy div 13) * 3), font (4), red)
		if (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y)) <= Ball_Mass then
		    Angle2 := arctand (abs (Charge_Ball_Y - B_Y) / abs (Charge_Ball_X - B_X))
		    if Ball_Charge not= Charge_Ball_Charge then
			if B_X < Charge_Ball_X then
			    Speed_X += ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			else
			    Speed_X -= ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			end if
			if B_Y > Charge_Ball_Y then
			    Speed_Y -= ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			else
			    Speed_Y += ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			end if
		    else
			if B_X < Charge_Ball_X then
			    Speed_X -= ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			else
			    Speed_X += ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			end if
			if B_Y > Charge_Ball_Y then
			    Speed_Y += ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			else
			    Speed_Y -= ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			end if
		    end if
		end if
		if Math.Distance (round (Spring_X), round (Spring_Y), round (B_X), round (B_Y)) <= maxy div 75 + Ball_Mass div 10 then
		    Angle3 := arctand (abs (Spring_Y - B_Y) / abs (Spring_X - B_X))
		    if Speed_X < 0 then
			if B_X > Spring_X then
			    Speed_X := -Speed_X
			end if
		    else
			if B_X < Spring_X then
			    Speed_X := -Speed_X
			end if
		    end if
		    if Speed_Y < 0 then
			if B_Y > Spring_Y then
			    Speed_Y := -Speed_Y
			end if
		    else
			if B_Y < Spring_Y then
			    Speed_Y := -Speed_Y
			end if
		    end if
		end if
		drawline (round (Charge_Ball_X + Ball_Mass div 13), round (Charge_Ball_Y), round (Charge_Ball_X - Ball_Mass div 13), round (Charge_Ball_Y), white)
		if Charge_Ball_Charge = true then
		    drawline (round (Charge_Ball_X), round (Charge_Ball_Y + Ball_Mass div 13), round (Charge_Ball_X), round (Charge_Ball_Y - Ball_Mass div 13), white)
		end if
		drawline (round (B_X + Ball_Mass div 13), round (B_Y), round (B_X - Ball_Mass div 13), round (B_Y), white)
		if Ball_Charge = true then
		    drawline (round (B_X), round (B_Y + Ball_Mass div 13), round (B_X), round (B_Y - Ball_Mass div 13), white)
		end if
		drawfillbox (0, 0, maxx, maxy div 50, green)
		if Math.Distance (B_X, B_Y, Balloon_X, Balloon_Y) <= Ball_Mass div 2 then
		    Win := true
		    exit
		end if
		B_X += round (Speed_X / 3)
		B_Y += round (Speed_Y / 3)
		Speed_Y -= 4.9 / 3
		if BallHeight < B_Y then
		    BallHeight := round (B_Y)
		end if
		if B_Y - Ball_Mass div 10 <= maxy div 50 then
		    Speed_Y := abs (0.75 * Speed_Y)
		    if abs (Speed_Y) < 10 then
			Speed_Y := 0
		    end if
		    Speed_X := Speed_X * 0.75
		end if
		if Bow_Angle not= -1000 then
		    Font.Draw ("Angle: " + intstr (round (Bow_Angle)), maxx - maxx div 10, maxy - maxy div 75, font (4), red)
		else
		    Font.Draw ("Angle: Undefined", maxx - maxx div 10, maxy - maxy div 75, font (4), red)
		end if
		if chars (KEY_UP_ARROW) then
		    exit
		end if
		if chars ('q') then
		    Test_Delay += 10
		end if
		if chars ('w') and Test_Delay > 0 then
		    Test_Delay -= 10
		end if
		delay (Test_Delay)
		View.Update
		if chars (KEY_DOWN_ARROW) then
		    loop
			Input.KeyDown (chars)
			if chars (KEY_LEFT_ARROW) then
			    exit
			end if
		    end loop
		end if
	    end loop
	    exit when Win = true
	end loop
	if qui not= true then
	    Font.Draw ("Level 1 Complete!", maxx div 3, maxy - maxy div 3, font (1), red)
	    View.Update
	    getch (cont)
	    cls
	    Win := false
	    Font.Draw ("Level 2", maxx div 2 - maxx div 14, maxy div 2, font (1), red)
	    P_X := maxx - maxx div 5
	    P_Y := maxy - maxy div 5
	    Ball_Mass := 100
	    Charge_Ball_X := maxx - maxx div 3
	    Charge_Ball_Y := maxy div 2
	    Balloon_X := maxx div 5
	    Balloon_Y := maxy div 4
	    Ball_Charge := true
	    Charge_Ball_Charge := true
	    Spring_X := maxx div 2
	    Spring_Y := maxy div 50 * 2
	    Cooldown := false
	    move := false
	    View.Update
	    getch (cont)
	    cls
	    loop
		colourback (black)
		loop
		    cls
		    mousewhere (mx, my, b)
		    if chars ('q') then
			Test_Delay += 10
		    end if
		    if chars ('w') and Test_Delay > 0 then
			Test_Delay -= 10
		    end if
		    for i : 1 .. 350
			drawdot (Snow (i).X, Snow (i).Y, white)
			Snow (i).X += Snow (i).X_Speed
			Snow (i).Y += Snow (i).Y_Speed
			if Snow (i).X > maxx or Snow (i).X < 0 or Snow (i).Y < 0 then
			    Snow (i).X := Rand.Int (0, maxx)
			    Snow (i).Y := maxy
			    Snow (i).X_Speed := Rand.Int (-5, 5)
			    Snow (i).Y_Speed := Rand.Int (-5, 5)
			end if
		    end for
		    Input.KeyDown (chars)
		    if chars ('z') then
			qui := true
			exit
		    end if
		    if mx = P_X then
			Bow_Angle := -1000
		    else
			Bow_Angle := arctand (abs (my - (P_Y + maxy div 50)) / abs (mx - P_X))
			if mx > P_X then
			    B_X := P_X + (maxy div 50 * cosd (Bow_Angle))
			    if my < P_Y then
				B_Y := P_Y + maxy div 50 - (sind (Bow_Angle) * maxy div 50)
			    else
				B_Y := P_Y + maxy div 50 + (sind (Bow_Angle) * maxy div 50)
			    end if
			else
			    B_X := P_X - (maxy div 50 * cosd (Bow_Angle))
			    if my < P_Y then
				B_Y := (P_Y + maxy div 50) - (sind (Bow_Angle) * maxy div 50)
			    else
				B_Y := (P_Y + maxy div 50) + (sind (Bow_Angle) * maxy div 50)
			    end if
			end if
		    end if
		    if Place_Mode = true then
			if b = 1 and mx > Charge_Ball_X - Ball_Mass div 10 and mx < Charge_Ball_X + Ball_Mass div 10 and my > Charge_Ball_Y - Ball_Mass div 10 and my < Charge_Ball_Y + Ball_Mass
				div 10
				then
			    move := true
			end if
			if move = true then
			    Charge_Ball_X := mx
			    Charge_Ball_Y := my
			end if
			if b = 0 then
			    move := false
			    move2 := false
			end if
			if b = 1 and mx > Spring_X - maxy div 50 and mx < Spring_X + maxy div 50 and my > Spring_Y and my < Spring_Y + maxy div 50 then
			    move2 := true
			end if
			if move2 = true then
			    Spring_X := mx
			    Spring_Y := my
			end if
		    end if
		    drawline (P_X, P_Y + maxy div 50, round (B_X), round (B_Y), red)
		    drawfillbox (maxx div 7, maxy - (maxy div 8) * 2, maxx div 2, maxy - (maxy div 8) * 2 + maxy div 45, green)
		    drawfillbox (maxx - maxx div 7, maxy - (maxy div 8) * 2, maxx div 2 + maxx div 7, maxy - (maxy div 8) * 2 + maxy div 45, green)
		    drawfilloval (P_X, P_Y + maxy div 25, maxy div 75, maxy div 75, red)
		    drawline (P_X, P_Y, P_X, P_Y + maxy div 25, red)
		    drawline (P_X, P_Y, P_X - maxx div 75, maxy - (maxy div 8) * 2 + maxy div 45, red)
		    drawline (P_X, P_Y, P_X + maxx div 75, maxy - (maxy div 8) * 2 + maxy div 45, red)
		    if Place_Mode = false then
			drawline (round (B_X), round (B_Y), mx, my, white)
		    end if
		    drawfilloval (round (Spring_X), round (Spring_Y), maxy div 75, maxy div 75, red)
		    drawfilloval (round (B_X), round (B_Y), Ball_Mass div 10, Ball_Mass div 10, red)
		    drawfilloval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass div 10, Ball_Mass div 10, red)
		    drawline (round (Charge_Ball_X + Ball_Mass div 13), round (Charge_Ball_Y), round (Charge_Ball_X - Ball_Mass div 13), round (Charge_Ball_Y), white)
		    drawoval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass, Ball_Mass, red)
		    if Charge_Ball_Charge = true then
			drawline (round (Charge_Ball_X), round (Charge_Ball_Y + Ball_Mass div 13), round (Charge_Ball_X), round (Charge_Ball_Y - Ball_Mass div 13), white)
		    end if
		    drawline (round (B_X + Ball_Mass div 13), round (B_Y), round (B_X - Ball_Mass div 13), round (B_Y), white)
		    if Ball_Charge = true then
			drawline (round (B_X), round (B_Y + Ball_Mass div 13), round (B_X), round (B_Y - Ball_Mass div 13), white)
		    end if
		    if chars ('p') and Cooldown = false then
			if Place_Mode = true then
			    Place_Mode := false
			else
			    Place_Mode := true
			end if
			Cooldown := true
		    end if
		    if chars ('v') and Cooldown = false then
			if Ball_Charge = true then
			    Ball_Charge := false
			else
			    Ball_Charge := true
			end if
			Cooldown := true
		    end if
		    if chars ('c') and Cooldown = false then
			if Charge_Ball_Charge = true then
			    Charge_Ball_Charge := false
			else
			    Charge_Ball_Charge := true
			end if
			Cooldown := true
		    end if
		    drawfilloval (Balloon_X, Balloon_Y, Ball_Mass div 2, Ball_Mass div 2, red)
		    drawline (Balloon_X, Balloon_Y - Ball_Mass div 2, Balloon_X, Balloon_Y - Ball_Mass * 2, red)
		    if chars ('c') = false and chars ('v') = false and chars ('p') = false then
			Cooldown := false
		    end if
		    Speed := Math.Distance (mx, my, B_X, B_Y) div 25
		    if Bow_Angle not= -1000 then
			if mx > P_X then
			    Speed_X := cosd (Bow_Angle) * Speed
			else
			    Speed_X := - (cosd (Bow_Angle) * Speed)
			end if
			if my > P_Y + maxy div 50 then
			    Speed_Y := sind (Bow_Angle) * Speed
			else
			    Speed_Y := - (sind (Bow_Angle) * Speed)
			end if
		    end if
		    Font.Draw ("Speed: " + intstr (round (Speed)), maxx - maxx div 10, maxy - maxy div 25, font (4), red)
		    if Place_Mode = false then
			if Bow_Angle not= -1000 then
			    Font.Draw ("Angle: " + intstr (round (Bow_Angle)), maxx - maxx div 10, maxy - maxy div 75, font (4), red)
			else
			    Font.Draw ("Angle: Undefined", maxx - maxx div 10, maxy - maxy div 75, font (4), red)
			end if
		    end if
		    delay (Test_Delay)
		    View.Update
		    exit when b = 1 and Place_Mode = false
		end loop
		BallHeight := round (B_Y)
		exit when qui = true
		loop
		    cls
		    Input.KeyDown (chars)
		    for i : 1 .. 350
			drawdot (Snow (i).X, Snow (i).Y, white)
			Snow (i).X += Snow (i).X_Speed
			Snow (i).Y += Snow (i).Y_Speed
			if Snow (i).X > maxx or Snow (i).X < 0 or Snow (i).Y < 0 then
			    Snow (i).X := Rand.Int (0, maxx)
			    Snow (i).Y := maxy
			    Snow (i).X_Speed := Rand.Int (-5, 5)
			    Snow (i).Y_Speed := Rand.Int (-5, 5)
			end if
		    end for
		    drawfilloval (P_X, P_Y + maxy div 25, maxy div 75, maxy div 75, red)
		    drawoval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass, Ball_Mass, red)
		    drawfilloval (round (B_X), round (B_Y), Ball_Mass div 10, Ball_Mass div 10, red)
		    drawfilloval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass div 10, Ball_Mass div 10, red)
		    if (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y)) <= Ball_Mass then
			Angle2 := arctand (abs (Charge_Ball_Y - B_Y) / abs (Charge_Ball_X - B_X))
			if Ball_Charge not= Charge_Ball_Charge then
			    if B_X < Charge_Ball_X then
				Speed_X += ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			    else
				Speed_X -= ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			    end if
			    if B_Y > Charge_Ball_Y then
				Speed_Y -= ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			    else
				Speed_Y += ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			    end if
			else
			    if B_X < Charge_Ball_X then
				Speed_X -= ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			    else
				Speed_X += ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			    end if
			    if B_Y > Charge_Ball_Y then
				Speed_Y += ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			    else
				Speed_Y -= ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
			    end if
			end if
		    end if
		    if Math.Distance (round (Spring_X), round (Spring_Y), round (B_X), round (B_Y)) <= maxy div 75 + Ball_Mass div 10 then
			Angle3 := arctand (abs (Spring_Y - B_Y) / abs (Spring_X - B_X))
			if Speed_X < 0 then
			    if B_X > Spring_X then
				Speed_X := -Speed_X
			    end if
			else
			    if B_X < Spring_X then
				Speed_X := -Speed_X
			    end if
			end if
			if Speed_Y < 0 then
			    if B_Y > Spring_Y then
				Speed_Y := -Speed_Y
			    end if
			else
			    if B_Y < Spring_Y then
				Speed_Y := -Speed_Y
			    end if
			end if
		    end if
		    drawline (round (Charge_Ball_X + Ball_Mass div 13), round (Charge_Ball_Y), round (Charge_Ball_X - Ball_Mass div 13), round (Charge_Ball_Y), white)
		    if Charge_Ball_Charge = true then
			drawline (round (Charge_Ball_X), round (Charge_Ball_Y + Ball_Mass div 13), round (Charge_Ball_X), round (Charge_Ball_Y - Ball_Mass div 13), white)
		    end if
		    drawline (round (B_X + Ball_Mass div 13), round (B_Y), round (B_X - Ball_Mass div 13), round (B_Y), white)
		    if Ball_Charge = true then
			drawline (round (B_X), round (B_Y + Ball_Mass div 13), round (B_X), round (B_Y - Ball_Mass div 13), white)
		    end if
		    drawfillbox (maxx div 7, maxy - (maxy div 8) * 2, maxx div 2, maxy - (maxy div 8) * 2 + maxy div 45, green)
		    drawfillbox (maxx - maxx div 7, maxy - (maxy div 8) * 2, maxx div 2 + maxx div 7, maxy - (maxy div 8) * 2 + maxy div 45, green)
		    drawfilloval (Balloon_X, Balloon_Y, Ball_Mass div 2, Ball_Mass div 2, red)
		    drawline (Balloon_X, Balloon_Y - Ball_Mass div 2, Balloon_X, Balloon_Y - Ball_Mass * 2, red)
		    drawfilloval (round (Spring_X), round (Spring_Y), maxy div 75, maxy div 75, red)
		    drawline (P_X, P_Y, P_X, P_Y + maxy div 25, red)
		    drawline (P_X, P_Y, P_X - maxx div 75, maxy - (maxy div 8) * 2 + maxy div 45, red)
		    drawline (P_X, P_Y, P_X + maxx div 75, maxy - (maxy div 8) * 2 + maxy div 45, red)
		    Font.Draw ("Speed: " + intstr (round (Speed)), maxx - maxx div 10, maxy - maxy div 25, font (4), red)
		    Font.Draw ("X Speed: " + intstr (round (Speed_X)), maxx - maxx div 10, maxy - ((maxy div 13) * 2), font (4), red)
		    Font.Draw ("Y Speed: " + intstr (round (Speed_Y)), maxx - maxx div 10, maxy - ((maxy div 13) * 3), font (4), red)
		    if Bow_Angle not= -1000 then
			Font.Draw ("Angle: " + intstr (round (Bow_Angle)), maxx - maxx div 10, maxy - maxy div 75, font (4), red)
		    else
			Font.Draw ("Angle: Undefined", maxx - maxx div 10, maxy - maxy div 75, font (4), red)
		    end if
		    if Math.Distance (B_X, B_Y, Balloon_X, Balloon_Y) <= Ball_Mass div 2 + Ball_Mass div 10 then
			Win := true
			exit
		    end if
		    B_X += round (Speed_X / 3)
		    B_Y += round (Speed_Y / 3)
		    Speed_Y -= 4.9 / 3
		    if BallHeight < B_Y then
			BallHeight := round (B_Y)
		    end if
		    if B_Y - Ball_Mass div 10 <= maxy - (maxy div 8) * 2 + maxy div 45 and B_X > maxx div 7 and B_X < maxx div 2 and B_Y > maxy - (maxy div 8) * 2 then
			Speed_Y := abs (0.75 * Speed_Y)
			if abs (Speed_Y) < 10 then
			    Speed_Y := 0
			end if
			Speed_X := Speed_X * 0.75
		    end if
		    if B_Y - Ball_Mass div 10 <= maxy - (maxy div 8) * 2 + maxy div 45 and B_Y > maxy - (maxy div 8) * 2 and B_X > maxx div 2 + maxx div 7 and B_X < maxx - maxx div 7 then
			Speed_Y := abs (0.75 * Speed_Y)
			if abs (Speed_Y) < 8 then
			    Speed_Y := 0
			end if
			Speed_X := Speed_X * 0.75
		    end if
		    if B_Y < maxy - (maxy div 8) * 2 + maxy div 45 and B_Y > maxy - (maxy div 8) * 2 and B_X + Ball_Mass div 10 >= maxx div 7 and B_X < maxx div 2 then
			Speed_X := Speed_X * -0.75
		    end if
		    if chars (KEY_UP_ARROW) then
			exit
		    end if
		    if chars ('q') then
			Test_Delay += 10
		    end if
		    if chars ('w') and Test_Delay > 0 then
			Test_Delay -= 10
		    end if
		    delay (Test_Delay)
		    View.Update
		    if chars (KEY_DOWN_ARROW) then
			loop
			    Input.KeyDown (chars)
			    if chars (KEY_LEFT_ARROW) then
				exit
			    end if
			end loop
		    end if
		end loop
		exit when Win = true
	    end loop
	    if qui not= true then
		colourback (white)
		Font.Draw ("Level 2 Complete!", maxx div 3, maxy - maxy div 3, font (1), red)
		View.Update
		getch (cont)
		cls
		Font.Draw ("Level 3", maxx div 2, maxy div 2, font (1), red)
		P_X := maxx - maxx div 10
		P_Y := maxy div 25
		Ball_Mass := 100
		Charge_Ball_X := maxx div 2
		Charge_Ball_Y := maxy div 2
		Balloon_X := maxx div 10
		Balloon_Y := maxy div 4
		Ball_Charge := true
		Charge_Ball_Charge := true
		Spring_X := maxx div 2
		Spring_Y := maxy div 50 * 2
		Cooldown := false
		move := false
		Win := false
		View.Update
		getch (cont)
		cls
		loop
		    colourback (black)
		    loop
			cls
			for i : 1 .. 350
			    drawdot (Snow (i).X, Snow (i).Y, white)
			    Snow (i).X += Snow (i).X_Speed
			    Snow (i).Y += Snow (i).Y_Speed
			    if Snow (i).X > maxx or Snow (i).X < 0 or Snow (i).Y < 0 then
				Snow (i).X := Rand.Int (0, maxx)
				Snow (i).Y := maxy
				Snow (i).X_Speed := Rand.Int (-5, 5)
				Snow (i).Y_Speed := Rand.Int (-5, 5)
			    end if
			end for
			mousewhere (mx, my, b)
			Input.KeyDown (chars)
			if chars ('z') then
			    qui := true
			    exit
			end if
			drawfillbox (maxx div 5, maxy div 50, maxx div 6, maxy div 3 - maxy div 10, green)
			if mx = P_X then
			    Bow_Angle := -1000
			else
			    Bow_Angle := arctand (abs (my - (P_Y + maxy div 50)) / abs (mx - P_X))
			    if mx > P_X then
				B_X := P_X + (maxy div 50 * cosd (Bow_Angle))
				if my < P_Y then
				    B_Y := P_Y + maxy div 50 - (sind (Bow_Angle) * maxy div 50)
				else
				    B_Y := P_Y + maxy div 50 + (sind (Bow_Angle) * maxy div 50)
				end if
			    else
				B_X := P_X - (maxy div 50 * cosd (Bow_Angle))
				if my < P_Y then
				    B_Y := (P_Y + maxy div 50) - (sind (Bow_Angle) * maxy div 50)
				else
				    B_Y := (P_Y + maxy div 50) + (sind (Bow_Angle) * maxy div 50)
				end if
			    end if
			end if
			if Place_Mode = true then
			    if b = 1 and mx > Charge_Ball_X - Ball_Mass div 10 and mx < Charge_Ball_X + Ball_Mass div 10 and my > Charge_Ball_Y - Ball_Mass div 10 and my < Charge_Ball_Y + Ball_Mass
				    div 10
				    then
				move := true
			    end if
			    if move = true then
				Charge_Ball_X := mx
				Charge_Ball_Y := my
			    end if
			    if b = 0 then
				move := false
				move2 := false
			    end if
			    if b = 1 and mx > Spring_X - maxy div 50 and mx < Spring_X + maxy div 50 and my > Spring_Y and my < Spring_Y + maxy div 50 then
				move2 := true
			    end if
			    if move2 = true then
				Spring_X := mx
				Spring_Y := my
			    end if
			end if
			drawfillbox (0, 0, maxx, 0 + maxy div 50, green)
			drawfilloval (P_X, P_Y + maxy div 25, maxy div 75, maxy div 75, red)
			drawline (P_X, P_Y, P_X, P_Y + maxy div 25, red)
			drawline (P_X, P_Y, P_X - maxx div 75, P_Y - maxy div 50, red)
			drawline (P_X, P_Y, P_X + maxx div 75, P_Y - maxy div 50, red)
			if Place_Mode = false then
			    drawline (round (B_X), round (B_Y), mx, my, white)
			end if
			if chars ('q') then
			    Test_Delay += 10
			end if
			if chars ('w') and Test_Delay > 0 then
			    Test_Delay -= 10
			end if
			drawfilloval (round (Spring_X), round (Spring_Y), maxy div 75, maxy div 75, red)
			drawfilloval (round (B_X), round (B_Y), Ball_Mass div 10, Ball_Mass div 10, red)
			drawfilloval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass div 10, Ball_Mass div 10, red)
			drawline (round (Charge_Ball_X + Ball_Mass div 13), round (Charge_Ball_Y), round (Charge_Ball_X - Ball_Mass div 13), round (Charge_Ball_Y), white)
			drawoval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass, Ball_Mass, red)
			if Charge_Ball_Charge = true then
			    drawline (round (Charge_Ball_X), round (Charge_Ball_Y + Ball_Mass div 13), round (Charge_Ball_X), round (Charge_Ball_Y - Ball_Mass div 13), white)
			end if
			drawline (round (B_X + Ball_Mass div 13), round (B_Y), round (B_X - Ball_Mass div 13), round (B_Y), white)
			if Ball_Charge = true then
			    drawline (round (B_X), round (B_Y + Ball_Mass div 13), round (B_X), round (B_Y - Ball_Mass div 13), white)
			end if
			if chars ('p') and Cooldown = false then
			    if Place_Mode = true then
				Place_Mode := false
			    else
				Place_Mode := true
			    end if
			    Cooldown := true
			end if
			if chars ('v') and Cooldown = false then
			    if Ball_Charge = true then
				Ball_Charge := false
			    else
				Ball_Charge := true
			    end if
			    Cooldown := true
			end if
			if chars ('c') and Cooldown = false then
			    if Charge_Ball_Charge = true then
				Charge_Ball_Charge := false
			    else
				Charge_Ball_Charge := true
			    end if
			    Cooldown := true
			end if
			drawfilloval (Balloon_X, Balloon_Y, Ball_Mass div 2, Ball_Mass div 2, red)
			drawline (Balloon_X, Balloon_Y - Ball_Mass div 2, Balloon_X, Balloon_Y - Ball_Mass * 2, red)
			drawline (P_X, P_Y + maxy div 50, round (B_X), round (B_Y), red)
			if chars ('c') = false and chars ('v') = false and chars ('p') = false then
			    Cooldown := false
			end if
			Speed := Math.Distance (mx, my, B_X, B_Y) div 25
			if Bow_Angle not= -1000 then
			    if mx > P_X then
				Speed_X := cosd (Bow_Angle) * Speed
			    else
				Speed_X := - (cosd (Bow_Angle) * Speed)
			    end if
			    if my > P_Y + maxy div 50 then
				Speed_Y := sind (Bow_Angle) * Speed
			    else
				Speed_Y := - (sind (Bow_Angle) * Speed)
			    end if
			end if
			Font.Draw ("Speed: " + intstr (round (Speed)), maxx - maxx div 10, maxy - maxy div 25, font (4), red)
			if Place_Mode = false then
			    if Bow_Angle not= -1000 then
				Font.Draw ("Angle: " + intstr (round (Bow_Angle)), maxx - maxx div 10, maxy - maxy div 75, font (4), red)
			    else
				Font.Draw ("Angle: Undefined", maxx - maxx div 10, maxy - maxy div 75, font (4), red)
			    end if
			end if
			delay (Test_Delay)
			View.Update
			exit when b = 1 and Place_Mode = false
		    end loop
		    BallHeight := round (B_Y)
		    exit when qui = true
		    loop
			cls
			Input.KeyDown (chars)
			for i : 1 .. 350
			    drawdot (Snow (i).X, Snow (i).Y, white)
			    Snow (i).X += Snow (i).X_Speed
			    Snow (i).Y += Snow (i).Y_Speed
			    if Snow (i).X > maxx or Snow (i).X < 0 or Snow (i).Y < 0 then
				Snow (i).X := Rand.Int (0, maxx)
				Snow (i).Y := maxy
				Snow (i).X_Speed := Rand.Int (-5, 5)
				Snow (i).Y_Speed := Rand.Int (-5, 5)
			    end if
			end for
			if B_X <= (maxx div 5) + (Ball_Mass div 10) and B_Y - (Ball_Mass div 10) < maxy div 3 - maxy div 10 then
			    Speed_X := - (Speed_X * 0.75)
			end if

			drawfillbox (maxx div 5, maxy div 50, maxx div 6, maxy div 3 - maxy div 10, green)
			drawline (maxx div 5, maxy div 50, maxx div 5, maxy div 3 - maxy div 10, green)
			drawfilloval (P_X, P_Y + maxy div 25, maxy div 75, maxy div 75, red)
			drawoval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass, Ball_Mass, red)
			drawfilloval (round (B_X), round (B_Y), Ball_Mass div 10, Ball_Mass div 10, red)
			drawfilloval (round (Charge_Ball_X), round (Charge_Ball_Y), Ball_Mass div 10, Ball_Mass div 10, red)
			drawfilloval (Balloon_X, Balloon_Y, Ball_Mass div 2, Ball_Mass div 2, red)
			drawline (Balloon_X, Balloon_Y - Ball_Mass div 2, Balloon_X, Balloon_Y - Ball_Mass * 2, red)
			drawfilloval (round (Spring_X), round (Spring_Y), maxy div 75, maxy div 75, red)
			drawline (P_X, P_Y, P_X, P_Y + maxy div 25, red)
			drawline (P_X, P_Y, P_X - maxx div 75, P_Y - maxy div 50, red)
			drawline (P_X, P_Y, P_X + maxx div 75, P_Y - maxy div 50, red)
			Font.Draw ("Speed: " + intstr (round (Speed)), maxx - maxx div 10, maxy - maxy div 25, font (4), red)
			Font.Draw ("X Speed: " + intstr (round (Speed_X)), maxx - maxx div 10, maxy - ((maxy div 13) * 2), font (4), red)
			Font.Draw ("Y Speed: " + intstr (round (Speed_Y)), maxx - maxx div 10, maxy - ((maxy div 13) * 3), font (4), red)
			if (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y)) <= Ball_Mass then
			    Angle2 := arctand (abs (Charge_Ball_Y - B_Y) / abs (Charge_Ball_X - B_X))
			    if Ball_Charge not= Charge_Ball_Charge then
				if B_X < Charge_Ball_X then
				    Speed_X += ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
				else
				    Speed_X -= ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
				end if
				if B_Y > Charge_Ball_Y then
				    Speed_Y -= ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
				else
				    Speed_Y += ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
				end if
			    else
				if B_X < Charge_Ball_X then
				    Speed_X -= ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
				else
				    Speed_X += ((Ball_Mass div 10 * sind (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
				end if
				if B_Y > Charge_Ball_Y then
				    Speed_Y += ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
				else
				    Speed_Y -= ((Ball_Mass div 10 * cosd (Angle2)) / 4) * (Math.Distance (Charge_Ball_X, Charge_Ball_Y, B_X, B_Y) div 30)
				end if
			    end if
			end if
			if Math.Distance (round (Spring_X), round (Spring_Y), round (B_X), round (B_Y)) <= maxy div 75 + Ball_Mass div 10 then
			    Angle3 := arctand (abs (Spring_Y - B_Y) / abs (Spring_X - B_X))
			    if Speed_X < 0 then
				if B_X > Spring_X then
				    Speed_X := -Speed_X
				end if
			    else
				if B_X < Spring_X then
				    Speed_X := -Speed_X
				end if
			    end if
			    if Speed_Y < 0 then
				if B_Y > Spring_Y then
				    Speed_Y := -Speed_Y
				end if
			    else
				if B_Y < Spring_Y then
				    Speed_Y := -Speed_Y
				end if
			    end if
			end if
			drawline (round (Charge_Ball_X + Ball_Mass div 13), round (Charge_Ball_Y), round (Charge_Ball_X - Ball_Mass div 13), round (Charge_Ball_Y), white)
			if Charge_Ball_Charge = true then
			    drawline (round (Charge_Ball_X), round (Charge_Ball_Y + Ball_Mass div 13), round (Charge_Ball_X), round (Charge_Ball_Y - Ball_Mass div 13), white)
			end if
			drawline (round (B_X + Ball_Mass div 13), round (B_Y), round (B_X - Ball_Mass div 13), round (B_Y), white)
			if Ball_Charge = true then
			    drawline (round (B_X), round (B_Y + Ball_Mass div 13), round (B_X), round (B_Y - Ball_Mass div 13), white)
			end if
			drawfillbox (0, 0, maxx, maxy div 50, green)
			if Math.Distance (B_X, B_Y, Balloon_X, Balloon_Y) <= Ball_Mass div 2 then
			    Win := true
			    exit
			end if
			B_X += round (Speed_X / 3)
			B_Y += round (Speed_Y / 3)
			Speed_Y -= 4.9 / 3
			if BallHeight < B_Y then
			    BallHeight := round (B_Y)
			end if
			if B_Y - Ball_Mass div 10 <= maxy div 50 then
			    Speed_Y := abs (0.75 * Speed_Y)
			    if abs (Speed_Y) < 10 then
				Speed_Y := 0
			    end if
			    Speed_X := Speed_X * 0.75
			end if
			if Bow_Angle not= -1000 then
			    Font.Draw ("Angle: " + intstr (round (Bow_Angle)), maxx - maxx div 10, maxy - maxy div 75, font (4), red)
			else
			    Font.Draw ("Angle: Undefined", maxx - maxx div 10, maxy - maxy div 75, font (4), red)
			end if
			if chars (KEY_UP_ARROW) then
			    exit
			end if
			if chars ('q') then
			    Test_Delay += 10
			end if
			if chars ('w') and Test_Delay > 0 then
			    Test_Delay -= 10
			end if
			delay (Test_Delay)
			View.Update
			if chars (KEY_DOWN_ARROW) then
			    loop
				Input.KeyDown (chars)
				if chars (KEY_LEFT_ARROW) then
				    exit
				end if
			    end loop
			end if
		    end loop
		    exit when Win = true
		end loop
		if qui not= true then
		    colourback (white)
		    Font.Draw ("Level 3 Complete!", maxx div 3, maxy - maxy div 3, font (1), red)
		    View.Update
		    getch (cont)
		end if
	    end if
	end if
    else
	count := 0
	ballx (1) := 0
	ballx (2) := maxx
	ballx (3) := maxx div 2
	bally (1) := maxy - (maxy div 3)
	bally (2) := maxy div 2
	bally (3) := maxy
	for i : 1 .. Ball_Num
	    ballhere (i) := true
	    ballyspeed (i) := Rand.Int (-15, -10)
	    ballx (i) := Rand.Int (0, maxx)
	    bally (i) := Rand.Int (maxy div 2, maxy)
	    ballxspeed (i) := Rand.Int (-10, 10)
	end for
	loop
	    cls
	    Font.Draw ("SCIENCE!", maxx div 2, maxy - maxy div 4, font (1), red)
	    for i : 1 .. Ball_Num
		if ballhere (i) = true then
		    if i = 1 then
			drawfilloval (round (ballx (i)), round (bally (i)), maxx div 100, maxx div 100, ballcolour (i))
		    else
			drawfilloval (round (ballx (i)), round (bally (i)), maxx div 100, maxx div 100, ballcolour (i))
		    end if
		    if bally (i) <= 0 then
			ballyspeed (i) := -ballyspeed (i) * 0.8
			random := Rand.Int (0, 3)
			if random = 0 then
			    ballhere (i) := false
			    count += 1
			end if
		    end if
		end if
	    end for
	    for i : 1 .. Ball_Num
		if ballhere (i) = true then
		    ballx (i) += ballxspeed (i)
		    if ballx (i) > maxx or ballx (i) < 0 then
			ballxspeed (i) := -1 * ballxspeed (i)
		    end if
		    bally (i) += ballyspeed (i)
		    if ballyspeed (i) not= 0 then
			ballyspeed (i) := ballyspeed (i) - 4.9
		    end if
		end if
	    end for
	    delay (15 * Ball_Num div 30)
	    View.Update
	    exit when count = Ball_Num
	end loop
    end if
end loop

