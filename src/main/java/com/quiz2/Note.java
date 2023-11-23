package com.quiz2;

public class Note {
    private String id;
    private String title;
    private String content;
    private String color;
    private boolean pinned;
    private String createdAt;
    private String updatedAt;

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }
    
    public String getColor() {
    	return color;
    }
    
    public boolean getPinned() {
    	return pinned;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public void setColor(String color) {
    	this.color = color;
    }
    
    public void setPinned(boolean pinned) {
    	this.pinned = pinned;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }
}