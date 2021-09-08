package org.ict.controller.di.classfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component	// bean container에 주입
public class Satellite {
	
	private Broadcast broadcast;
	
	@Autowired
	public Satellite(Broadcast broadcast) {
		this.broadcast = broadcast;
	}
	public void satellite() {
		System.out.print("위성방식 ");
		broadcast.broadcast();
	}

}
