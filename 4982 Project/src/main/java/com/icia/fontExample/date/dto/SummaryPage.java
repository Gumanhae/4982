package com.icia.fontExample.date.dto;

import java.util.*;

import com.icia.fontExample.entity.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SummaryPage {
	private int pageno;
	private int pagesize;
	private int totalcount;
	private List<Summary> summarys;

}
