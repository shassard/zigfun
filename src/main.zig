const std = @import("std");

pub fn main() anyerror!void {
    var allocator = std.heap.GeneralPurposeAllocator(.{}){};

    var folder = std.fs.cwd().openDir(".", .{ .iterate = true }) catch |err| return err;
    var it = folder.iterate();
    while (try it.next()) |entry| {
        switch (entry.kind) {
            std.fs.Dir.Entry.Kind.File => std.debug.print("{} => {}\n", .{
                entry.name,
                std.ascii.allocLowerString(&allocator.allocator, entry.name),
            }),
            else => continue,
        }
    }
}
