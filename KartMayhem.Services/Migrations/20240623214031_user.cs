using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace KartMayhem.Services.Migrations
{
    /// <inheritdoc />
    public partial class user : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Kupovinas",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Cijena = table.Column<int>(type: "int", nullable: false),
                    DatumKupovine = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PaymentIntentId = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Placena = table.Column<bool>(type: "bit", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    StazeId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kupovinas", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Kupovinas_Korisnicis_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnicis",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Kupovinas_Stazes_StazeId",
                        column: x => x.StazeId,
                        principalTable: "Stazes",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Kupovinas_KorisnikId",
                table: "Kupovinas",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Kupovinas_StazeId",
                table: "Kupovinas",
                column: "StazeId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Kupovinas");
        }
    }
}
