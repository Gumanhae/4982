package com.icia.fontExample.date.dto;

import java.util.*;

import com.icia.fontExample.entity.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LargeCateDto {
	List<LargeCategory> largeCategory;
}
