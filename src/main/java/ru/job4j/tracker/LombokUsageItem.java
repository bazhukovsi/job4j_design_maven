package ru.job4j.tracker;

public class LombokUsageItem {
    public static void main(String[] args) {
        var item = new Item();
        item.setName("Work");
        System.out.println(item);
    }
}
