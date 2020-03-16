package com.icia.fontExample.entity;

import java.util.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UploadInfo {
	private long no;
	private String name;
	private String username;
	private long lno;
	private long sno;
	private long price;
	private String postcode1;
	private String postcode2;
	private long quantity;
	private String information;
	private List<String> tags;
	private String image;
	private long state;
}

