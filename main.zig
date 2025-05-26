pub fn main() void {
    _ = SendInput(6, &.{
        .ki(.{ .wVk = 0xa2, .dwFlags = 0 }),
        .ki(.{ .wVk = 0x5b, .dwFlags = 0 }),
        .ki(.{ .wVk = 0x87, .dwFlags = 0 }),
        .ki(.{ .wVk = 0x87, .dwFlags = 2 }),
        .ki(.{ .wVk = 0x5b, .dwFlags = 2 }),
        .ki(.{ .wVk = 0xa2, .dwFlags = 2 }),
    }, @sizeOf(INPUT));
}

extern "user32" fn SendInput(cInputs: u32, pInputs: [*]const INPUT, cbSize: i32) callconv(.winapi) u32;
const INPUT = extern struct {
    type: u32,
    input: extern union {
        mi: MOUSEINPUT,
        ki: KEYBDINPUT,
        hi: HARDWAREINPUT,
    },
    const MOUSEINPUT = extern struct {
        dx: i32 = 0,
        dy: i32 = 0,
        mouseData: i32 = 0,
        dwFlags: u32 = 0,
        time: u32 = 0,
        dwExtraInfo: usize = 0,
    };
    const KEYBDINPUT = extern struct {
        wVk: u16 = 0,
        wScan: u16 = 0,
        dwFlags: u32 = 0,
        time: u32 = 0,
        dwExtraInfo: usize = 0,
    };
    const HARDWAREINPUT = extern struct {
        uMsg: u32 = 0,
        wParamL: u16 = 0,
        wParamH: u16 = 0,
    };
    fn mi(m: MOUSEINPUT)    INPUT { return .{ .type = 0, .input = .{ .mi = m } }; }
    fn ki(k: KEYBDINPUT)    INPUT { return .{ .type = 1, .input = .{ .ki = k } }; }
    fn hi(h: HARDWAREINPUT) INPUT { return .{ .type = 2, .input = .{ .hi = h } }; }
};