const SPI_DEV = "/dev/spidev0.0"
const O_RDWR = 0x0002

const fd = ccall(:open, Int32, (Cstring, Int32), SPI_DEV, O_RDWR)

# IMPORTANT: struct EXACT Linux spidev
mutable struct spi_ioc_transfer
    tx_buf::UInt64
    rx_buf::UInt64
    len::UInt32
    speed_hz::UInt32
    delay_usecs::UInt16
    bits_per_word::UInt8
    cs_change::UInt8
    tx_nbits::UInt8
    rx_nbits::UInt8
    pad::UInt32
end

function spi_xfer(tx::Vector{UInt8})
    rx = zeros(UInt8, length(tx))

    transfer = spi_ioc_transfer(
        UInt64(pointer(tx)),
        UInt64(pointer(rx)),
        UInt32(length(tx)),
        UInt32(50000),
        UInt16(0),
        UInt8(8),
        UInt8(0),
        UInt8(0),
        UInt8(0),
        UInt32(0)
    )

    SPI_IOC_MESSAGE_1 = 0x40206B00

    ccall(:ioctl, Int32,
        (Int32, UInt64, Ptr{spi_ioc_transfer}),
        fd,
        SPI_IOC_MESSAGE_1,
        Ref(transfer)
    )

    return rx
end

function spi_send(message::String)
    tx = Vector{UInt8}(codeunits(message))

    println("Sent: ", message)

    rx = spi_xfer(tx)

    println("RX bytes: ", rx)

    println("Received: ", String(Char.(rx)))
end

spi_send("Hello, World!")
