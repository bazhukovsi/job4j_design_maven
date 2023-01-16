package ru.job4j.tracker;

public class LombokUsageItem {
    public static void main(String[] args) {
        var item = new Item(1);
        item.setName("Work");
        System.out.println(item);
    }
}
