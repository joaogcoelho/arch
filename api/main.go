package main

import (
	"fmt"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	config := cors.Config{
		AllowOrigins:     []string{"*"},
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Accept"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: false,
		MaxAge:           12 * time.Hour,
	}
	r.Use(cors.New(config))

	r.GET("/api/products", func(c *gin.Context) {
		time.Sleep(1 * time.Second)
		products := generateFakeProductList(1000)
		c.JSON(200, gin.H{
			"data": products,
		})
	})

	r.Run(":3030")
}

type Product struct {
	Id   int    `json:"id"`
	Name string `json:"name"`
}

func generateFakeProductList(len int) []Product {
	products := []Product{}
	for i := 0; i < len; i++ {
		products = append(products, Product{
			Id:   i,
			Name: fmt.Sprintf("Product %d", i),
		})
	}
	return products
}
