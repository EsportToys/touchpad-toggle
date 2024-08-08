const WINAPI = @import("std").os.windows.WINAPI;
const INPUT = extern struct {
    type: u32,
    input: extern union {
        mi: extern struct {
            dx: i32 = 0,
            dy: i32 = 0,
            mouseData: i32 = 0,
            dwFlags: u32 = 0,
            time: u32 = 0,
            dwExtraInfo: usize = 0,
        },
        ki: extern struct {
            wVK: u16 = 0,
            wScan: u16 = 0,
            dwFlags: u32 = 0,
            time: u32 = 0,
            dwExtraInfo: usize = 0,
        },
        hi: extern struct {
            uMsg: u32 = 0,
            wParamL: u16 = 0,
            wParamH: u16 = 0,
        }
    },
};

extern "user32" fn SendInput(cInputs: u32, pInputs: [*]const INPUT, cbSize: i32) callconv(WINAPI) u32;

pub fn main() void {
    _ = SendInput(6, &.{
        kiVkey(0xa2,true),
        kiVkey(0x5b,true),
        kiVkey(0x87,true),
        kiVkey(0x87,false),
        kiVkey(0x5b,false),
        kiVkey(0xa2,false),
    }, @sizeOf(INPUT));
}

fn kiVkey(vkey: u16, state: bool) INPUT {
    return .{
        .type = 1,
        .input = .{
            .ki = .{
                .wVK = vkey,
                .dwFlags = if(state) 0 else 2,
            },
        },
    };
}