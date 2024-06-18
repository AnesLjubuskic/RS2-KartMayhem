using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace KartMayhem.Services.Migrations
{
    /// <inheritdoc />
    public partial class korisniciStaze1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "KorisniciStazes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisniciId = table.Column<int>(type: "int", nullable: false),
                    StazeId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisniciStazes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_KorisniciStazes_Korisnicis_KorisniciId",
                        column: x => x.KorisniciId,
                        principalTable: "Korisnicis",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_KorisniciStazes_Stazes_StazeId",
                        column: x => x.StazeId,
                        principalTable: "Stazes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciStazes_KorisniciId",
                table: "KorisniciStazes",
                column: "KorisniciId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciStazes_StazeId",
                table: "KorisniciStazes",
                column: "StazeId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "KorisniciStazes");
        }
    }
}
