using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace KartMayhem.Services.Migrations
{
    /// <inheritdoc />
    public partial class rezencije : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "RezervacijeOpremes");

            migrationBuilder.DropTable(
                name: "Opremes");

            migrationBuilder.DropColumn(
                name: "Komentar",
                table: "Rezencijes");

            migrationBuilder.AddColumn<int>(
                name: "Ocjena",
                table: "Rezencijes",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Ocjena",
                table: "Rezencijes");

            migrationBuilder.AddColumn<string>(
                name: "Komentar",
                table: "Rezencijes",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "Opremes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OpisOpreme = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Opremes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "RezervacijeOpremes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OpremaId = table.Column<int>(type: "int", nullable: false),
                    RezervacijaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RezervacijeOpremes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RezervacijeOpremes_Opremes_OpremaId",
                        column: x => x.OpremaId,
                        principalTable: "Opremes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RezervacijeOpremes_Rezervacijes_RezervacijaId",
                        column: x => x.RezervacijaId,
                        principalTable: "Rezervacijes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijeOpremes_OpremaId",
                table: "RezervacijeOpremes",
                column: "OpremaId");

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijeOpremes_RezervacijaId",
                table: "RezervacijeOpremes",
                column: "RezervacijaId");
        }
    }
}
