package vn.iotstar.filter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.content.tagrules.html.CoreHtmlTagRuleBundle;
import org.sitemesh.content.tagrules.html.Sm2TagRuleBundle;

import jakarta.servlet.annotation.WebFilter;

@WebFilter(filterName = "sitemesh", urlPatterns = "/*")
public class SiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder
            .addTagRuleBundle(new CoreHtmlTagRuleBundle())
            .addTagRuleBundle(new Sm2TagRuleBundle())
            .addExcludedPath("/decorators/*")
            .addExcludedPath("/WEB-INF/decorators/*")
            .addExcludedPath("/views/decorators/*")
            .addExcludedPath("/views/loi404.jsp")
            .addExcludedPath("/views/loi500.jsp")
            
            .addExcludedPath("/assets/*")
            .addExcludedPath("/image*")
            .addExcludedPath("/image/*")
            .addExcludedPath("/api/*")
            .addExcludedPath("/uploadFile*")
            .addExcludedPath("/multiPartServlet*")

            .addDecoratorPath("/admin/*", "admin.jsp")
            .addDecoratorPath("/admin", "admin.jsp")
            .addDecoratorPath("/*", "web.jsp");
    }
}
