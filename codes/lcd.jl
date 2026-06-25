module LCD_I2C

export lcd_init, lcd_print, lcd_clear, lcd_set_cursor

const LCD_ADDR = 0x27
const BUS = 1

function i2c_write_byte(data::Integer)
    run(`sudo i2cset -y $BUS $LCD_ADDR $(Int(data))`)
end

function lcd_toggle_enable(data::Integer)
    i2c_write_byte(data | 0x04)
    sleep(0.0005)
    i2c_write_byte(data & ~0x04)
    sleep(0.0005)
end

function lcd_send_nibble(nibble::Integer)
    nibble = Int(nibble)
    i2c_write_byte(nibble)
    lcd_toggle_enable(nibble)
end

function lcd_send_byte(bits::Integer, mode::Integer)
    bits = Int(bits)
    mode = Int(mode)

    high = mode | (bits & 0xF0) | 0x08
    low  = mode | ((bits << 4) & 0xF0) | 0x08

    lcd_send_nibble(high)
    lcd_send_nibble(low)
end

lcd_command(cmd::Integer) = lcd_send_byte(cmd, 0)
lcd_write_char(ch::Char) = lcd_send_byte(Int(ch), 1)

function lcd_init()
    sleep(0.05)

    lcd_send_nibble(0x30)
    sleep(0.005)

    lcd_send_nibble(0x30)
    sleep(0.005)

    lcd_send_nibble(0x30)
    sleep(0.005)

    lcd_send_nibble(0x20)

    lcd_command(0x28)
    lcd_command(0x0C)
    lcd_command(0x01)
    sleep(0.005)
    lcd_command(0x06)
end

function lcd_print(text::String)
    for c in text
        lcd_write_char(c)
    end
end

function lcd_clear()
    lcd_command(0x01)
    sleep(0.005)
end

function lcd_set_cursor(row::Int, col::Int)
    addr = col + (row == 0 ? 0x80 : 0xC0)
    lcd_command(addr)
end

end
