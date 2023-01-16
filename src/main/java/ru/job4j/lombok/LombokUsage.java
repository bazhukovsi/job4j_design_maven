package ru.job4j.lombok;

public class LombokUsage {
    public static void main(String[] args) {
        Permission permission = Permission.of()
                .id(1)
                .name("ADMIN")
                .accessBy("read")
                .accessBy("write")
                .accessBy("execute")
                .accessBy("read, write")
                .accessBy("read, execute")
                .accessBy("read, write, execute")
                .build();
        System.out.println(permission);
    }
}
