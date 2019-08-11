const server = require("express")({});

server.get("/", (req, res) => {
  res.send("Hello World 222222!");
});
console.log("server listen at 3000");
server.listen(3000);
