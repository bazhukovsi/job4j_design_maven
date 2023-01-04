package ru.job4j.assertj;

import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.*;

class BoxTest {
    @Test
    void isThisSphere() {
        Box box = new Box(0, 10);
        String name = box.whatsThis();
        assertThat(name).isEqualTo("Sphere");
    }

    @Test
    void isThisTetrahedron() {
        Box box = new Box(4, 10);
        String name = box.whatsThis();
        assertThat(name).isEqualTo("Tetrahedron");
    }

    @Test
    void isThisCube() {
        Box box = new Box(8, 10);
        String name = box.whatsThis();
        assertThat(name).isEqualTo("Cube");
    }

    @Test
    void isThisUnknown() {
        Box box = new Box(100, 10);
        String name = box.whatsThis();
        assertThat(name).isEqualTo("Unknown object");
    }

    @Test
    void isNegativeEdge() {
        Box box = new Box(100, -100);
        String name = box.whatsThis();
        assertThat(name).isEqualTo("Unknown object");
    }

    @Test
    void getNumberOfVertices4() {
        Box box = new Box(4, 10);
        int numberOfVertices = box.getNumberOfVertices();
        System.out.println(numberOfVertices);
        assertThat(numberOfVertices).isPositive();
    }

    @Test
    void getNumberOfVertices8() {
        Box box = new Box(8, 10);
        int numberOfVertices = box.getNumberOfVertices();
        System.out.println(numberOfVertices);
        assertThat(numberOfVertices).isGreaterThan(5);
    }

    @Test
    void isExistCube() {
        Box box = new Box(8, 10);
        boolean isExist = box.isExist();
        assertThat(isExist).isTrue();
    }

    @Test
    void isNotExist() {
        Box box = new Box(100, 10);
        boolean isExist = box.isExist();
        assertThat(isExist).isFalse();
    }

    @Test
    void getAreaCube() {
        Box box = new Box(8, 2);
        double area = box.getArea();
        assertThat(area).isEqualTo(24.0);
    }

    @Test
    void getAreaSphere() {
        Box box = new Box(8, 2);
        double area = box.getArea();
        assertThat(area).isGreaterThan(0);
    }

    @Test
    void getAreaTetrahedron() {
        Box box = new Box(8, 2);
        double area = box.getArea();
        assertThat(area).isLessThan(25);
    }

}