using .LCD_I2C

function main()
    lcd_init()
    lcd_clear()

    lcd_set_cursor(0, 0)
    lcd_print("Hello, World!")

    lcd_set_cursor(1, 0)
    lcd_print("Julia LCD OK")
end

main()
