package ru.job4j.tracker;

import lombok.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Data
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@RequiredArgsConstructor
public class Item  {
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd-MMMM-EEEE-yyyy HH:mm:ss");
    @Getter
    @NonNull
    @EqualsAndHashCode.Include
    private int id;
    @Getter
    @Setter
    private String name;
    private LocalDateTime created = LocalDateTime.now();
}

