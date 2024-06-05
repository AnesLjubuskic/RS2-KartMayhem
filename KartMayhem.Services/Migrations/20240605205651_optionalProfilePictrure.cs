using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace KartMayhem.Services.Migrations
{
    /// <inheritdoc />
    public partial class optionalProfilePictrure : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Slika",
                table: "Korisnicis",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Slika",
                table: "Korisnicis");
        }
    }
}
