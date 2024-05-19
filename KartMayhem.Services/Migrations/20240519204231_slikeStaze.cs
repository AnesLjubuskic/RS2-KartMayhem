using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace KartMayhem.Services.Migrations
{
    /// <inheritdoc />
    public partial class slikeStaze : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Slika",
                table: "Tezines",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Slika",
                table: "Stazes",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(byte[]),
                oldType: "varbinary(max)",
                oldNullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Slika",
                table: "Tezines");

            migrationBuilder.AlterColumn<byte[]>(
                name: "Slika",
                table: "Stazes",
                type: "varbinary(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);
        }
    }
}
